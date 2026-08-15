module diagnostics_m
   use, intrinsic :: iso_fortran_env, only: output_unit, error_unit
   implicit none
   private

   integer, parameter :: INFO = 0
   integer, parameter :: WARN = 1
   integer, parameter :: ERROR = 2

   type :: severity_t
      private
      integer :: code = INFO
   contains
      procedure :: to_string => severity_to_string
   end type severity_t

   type :: span_t
      private
      integer :: line = 1
      integer :: column = 1
   contains
      procedure :: print => span_print
   end type span_t

   type :: diagnostic_t
      private
      type(severity_t) :: severity
      type(span_t) :: span
      character(len=:), allocatable :: message
   contains
      procedure :: print => diagnostic_print
      procedure :: get_message => diagnostic_get_message
      procedure :: get_severity => diagnostic_get_severity
   end type diagnostic_t

   type :: diagnostic_box_t
      class(diagnostic_t), allocatable :: item
   end type diagnostic_box_t

   type, abstract :: sink_t
   contains
      procedure(emit_sig), deferred :: emit
      procedure(count_sig), deferred :: count
   end type sink_t

   abstract interface
      subroutine emit_sig(this, diagnostic)
         import :: sink_t, diagnostic_t

         class(sink_t), intent(inout) :: this
         type(diagnostic_t), intent(in) :: diagnostic
      end subroutine emit_sig

      function count_sig(this) result(count)
         import :: sink_t

         class(sink_t), intent(in) :: this
         integer :: count
      end function count_sig
   end interface

   type, extends(sink_t) :: stderr_sink_t
      private
      integer:: emitted = 0
   contains
      procedure :: emit => stderr_emit
      procedure :: count => stderr_count
      procedure :: describe => stderr_describe
   end type stderr_sink_t

   type, extends(sink_t) :: memory_sink_t
      private
      type(diagnostic_box_t), dimension(:), allocatable :: diagnostics
      integer :: used = 0
   contains
      procedure :: emit => memory_emit
      procedure :: count => memory_count
      procedure :: describe => memory_describe
      procedure :: print_all => memory_print_all

      final :: finalize_memory_sink
   end type memory_sink_t

   public :: diagnostic_t, make_span, make_diagnostic, sink_t, stderr_sink_t, &
      make_stderr_sink, memory_sink_t,  make_memory_sink

contains
   function make_severity(code) result(severity)
      implicit none

      integer, intent(in) :: code
      type(severity_t) :: severity

      severity%code = code
   end function make_severity

   function severity_to_string(this) result(severity)
      implicit none

      class(severity_t), intent(in) :: this
      character(len=:), allocatable :: severity

      select case (this%code)
       case (0)
         severity = 'info'
       case (1)
         severity = 'warning'
       case (2)
         severity = 'error'
       case default
         error stop 'invalid severity'
      end select
   end function severity_to_string

   function make_span(line, column) result(span)
      implicit none

      integer, intent(in) :: line
      integer, intent(in) :: column
      type(span_t) :: span

      if (line < 1) error stop '[span] line cannot be less than 1'
      if (column < 1) error stop '[span] column cannot be less than 1'

      span%line = line
      span%column = column
   end function make_span

   subroutine span_print(this)
      implicit none

      class(span_t), intent(in) :: this

      write (output_unit, '("line ",I0," column ",I0)', advance='no') this%line, this%column
   end subroutine span_print

   function make_diagnostic(severity_str, span, message) result(diagnostic)
      implicit none

      character(len=*), intent(in) :: severity_str
      type(span_t), intent(in) :: span
      character(len=*), intent(in) :: message
      type(diagnostic_t) :: diagnostic

      select case(trim(severity_str))
       case ('info')
         diagnostic%severity%code = 0
       case ('warning')
         diagnostic%severity%code = 1
       case ('error')
         diagnostic%severity%code = 2
       case default
         error stop '[make_diagnostic] unknown severity'
      end select

      diagnostic%span = span
      diagnostic%message = message
   end function make_diagnostic

   function diagnostic_get_message(this) result(message)
      implicit none

      class(diagnostic_t), intent(in) :: this
      character(len=:), allocatable :: message

      message = this%message
   end function diagnostic_get_message

   function diagnostic_get_severity(this) result(severity)
      implicit none

      class(diagnostic_t), intent(in) :: this
      character(len=:), allocatable :: severity

      severity = this%severity%to_string()
   end function diagnostic_get_severity

   subroutine diagnostic_print(this)
      implicit none

      class(diagnostic_t), intent(in) :: this

      write (output_unit, '(A)', advance='no') this%severity%to_string() // ':'
      call this%span%print()
      write (output_unit, '(":",A)') this%message
   end subroutine diagnostic_print

   function make_stderr_sink() result(sink)
      implicit none

      type(stderr_sink_t) :: sink

      sink%emitted = 0
   end function make_stderr_sink

   subroutine stderr_emit(this, diagnostic)
      implicit none

      class(stderr_sink_t), intent(inout) :: this
      type(diagnostic_t), intent(in) :: diagnostic

      call diagnostic%print()
      this%emitted = this%emitted + 1
   end subroutine stderr_emit

   function stderr_count(this) result(count)
      implicit none

      class(stderr_sink_t), intent(in) :: this
      integer :: count

      count = this%emitted
   end function stderr_count

   subroutine stderr_describe(this)
      implicit none

      class(stderr_sink_t), intent(in) :: this

      write (output_unit, '("stderr sink, emitted = ",I5)') this%emitted
   end subroutine stderr_describe

   function make_memory_sink(capacity) result(sink)
      implicit none

      integer, intent(in) :: capacity
      type(memory_sink_t) :: sink
      integer :: stat
      character(len=512) :: errmsg

      if (capacity < 1) then
         error stop 'invalid size for memory sink'
      end if

      allocate(sink%diagnostics(capacity), stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)

      sink%used = 0
   end function make_memory_sink

   subroutine memory_emit(this, diagnostic)
      implicit none

      class(memory_sink_t), intent(inout) :: this
      type(diagnostic_t), intent(in) :: diagnostic
      integer :: stat
      character(len=512) :: errmsg

      if (.not. allocated(this%diagnostics)) then
         error stop 'diagnostics is not allocated for memory sink'
      end if

      if (this%used >= size(this%diagnostics)) then
         error stop 'memory sink capacity exhausted'
      end if

      this%used = this%used + 1
      allocate(this%diagnostics(this%used)%item, stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)
      this%diagnostics(this%used)%item = diagnostic
   end subroutine memory_emit

   function memory_count(this) result(count)
      implicit none

      class(memory_sink_t), intent(in) :: this
      integer :: count

      count = this%used
   end function memory_count

   subroutine memory_describe(this)
      implicit none

      class(memory_sink_t), intent(in) :: this

      write (output_unit, '("memory sink, used = ",I5)') this%used
   end subroutine memory_describe

   subroutine memory_print_all(this)
      implicit none

      class(memory_sink_t), intent(in) :: this
      integer :: i

      do i = 1, this%used
         call this%diagnostics(i)%item%print()
      end do
   end subroutine memory_print_all

   subroutine finalize_memory_sink(this)
      implicit none

      type(memory_sink_t), intent(inout) :: this
      integer :: stat
      character(len=512) :: errmsg

      if (allocated(this%diagnostics)) then
         deallocate(this%diagnostics, stat=stat, errmsg=errmsg)
      end if
   end subroutine finalize_memory_sink

   subroutine check_mem(stat, errmsg)
      implicit none

      integer, intent(in) :: stat
      character(len=*), intent(in) :: errmsg

      if (stat /= 0) then
         write (error_unit, *) 'Allocation/Deallocation error: ' // errmsg
         error stop
      end if
   end subroutine check_mem
end module diagnostics_m
