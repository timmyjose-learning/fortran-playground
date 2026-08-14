module logger_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: logger_t
   contains
      procedure, pass(this) :: log => log_basic
   end type logger_t

   type, extends(logger_t) :: timestamp_logger_t
   contains
      procedure, pass(this) :: log => log_with_timestamp
   end type timestamp_logger_t

   public :: logger_t, timestamp_logger_t

contains
   subroutine log_basic(this, message)
      implicit none

      class(logger_t), intent(in) :: this
      character(len=*), intent(in) :: message

      write (output_unit, '("[log] ",A)') message
   end subroutine log_basic

   subroutine log_with_timestamp(this, message)
      implicit none

      class(timestamp_logger_t), intent(in) :: this
      character(len=*), intent(in) :: message

      write (output_unit, '("[",A,"] [log] ",A)') get_current_time(), message
   end subroutine log_with_timestamp

   function get_current_time() result(curr_time_str)
      implicit none

      integer, dimension(8) :: curr_time
      character(len=512) :: buffer
      character(len=:), allocatable :: curr_time_str

      call date_and_time(values=curr_time)
      write (buffer, '(I4.4,"-",I2.2,"-",I2.2," ",I2.2,"-",I2.2,"-",I2.2)') &
         curr_time(1), curr_time(2), curr_time(3), &
         curr_time(5), curr_time(6), curr_time(7)

      curr_time_str = trim(adjustl(buffer))
   end function get_current_time
end module logger_m

program inheritance_and_overriding
   use logger_m, only: logger_t, timestamp_logger_t
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      class(logger_t), pointer :: log_ptr
      type(logger_t), target :: basic_logger
      type(timestamp_logger_t), target :: ts_logger

      log_ptr => basic_logger
      call log_ptr%log('Something went wrong')

      log_ptr => ts_logger
      call log_ptr%log('Something awful happened!')
   end subroutine
end program inheritance_and_overriding