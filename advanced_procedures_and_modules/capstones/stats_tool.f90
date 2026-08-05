module stats_m
   use, intrinsic :: iso_fortran_env, only: output_unit, real64
   implicit none
   private

   public :: recursive_sum, get_scale_from_env, print_report

contains
   recursive function recursive_sum(arr, low, high) result(sum)
      implicit none

      real(kind=real64), dimension(:), intent(in) :: arr
      integer, intent(inout) :: low
      integer, intent(in) :: high
      real(kind=real64) :: sum

      sum = 0.0

      if (low > high) then
         sum = sum + 0
      else
         sum = sum + arr(low)
         low = low + 1
         sum = sum + recursive_sum(arr, low, high)
      end if
   end function recursive_sum

   subroutine get_scale_from_env(key, scale, scale_used)
      implicit none

      character(len=*), intent(in) :: key
      real(kind=real64), intent(out) :: scale
      logical, intent(out) :: scale_used

      character(len=512) :: scale_buffer
      integer :: status
      integer :: length

      integer :: iostat
      character(len=512) :: iomsg

      call get_environment_variable(key, scale_buffer, length=length, status=status)

      if (status == 0 .and. length > 0) then
         block
            read (scale_buffer(:length),*, iostat=iostat, iomsg=iomsg) scale

            if (iostat /= 0) then
               scale = 1.0
               scale_used = .false.
               return
            end if

            scale_used = .true.
         end block
      else
         scale = 1.0
         scale_used = .false.
      end if
   end subroutine get_scale_from_env

   subroutine print_report(values, total, label, scale)
      implicit none

      real(kind=real64), dimension(:), intent(in) :: values
      real(kind=real64) :: total
      character(len=*), intent(in) :: label
      real(kind=real64), intent(in) :: scale

      integer :: count
      real(kind=real64) :: mean

      count = size(values)
      mean = total / real(count)

      write (output_unit, '(A,A)') 'Report: ', label
      write (output_unit, '(A,F8.3)') 'Scale: ', scale
      write (output_unit, '(A,I5)') 'Count = ', count
      write (output_unit, '(A,F8.3)') 'Sum = ', total
      write (output_unit, '(A,F8.3)') 'Mean = ', mean
   end subroutine print_report
end module stats_m

program stats_tool
   use, intrinsic :: iso_fortran_env, only: real64, error_unit
   use stats_m, only: recursive_sum, get_scale_from_env, print_report
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      integer :: argc
      character(len=128) :: arg
      integer :: n = 0
      integer :: i

      integer :: iostat
      integer :: status

      real(kind=real64), dimension(:), allocatable :: arr
      real(kind=real64) :: total
      real(kind=real64) :: scale
      character(len=:), allocatable :: label
      character(len=512) :: label_buffer
      integer :: length
      logical :: scale_used
      integer :: low, high

      argc = command_argument_count()

      if (argc == 0) then
         write (error_unit, *) 'Usage: ./<tool> [number]+'
         return
      end if

      allocate(arr(argc))

      do i = 1, argc
         call get_command_argument(i, arg)

         block
            real(kind=real64) :: rval

            read (arg, *, iostat=iostat) rval

            if (iostat /= 0) then
               write (error_unit, *) 'Skipping invalid number argument...'
               cycle
            end if

            n = n + 1
            arr(n) = rval
         end block
      end do

      if (n == 0) then
         write (error_unit, *) 'No values were provided...'
         return
      end if

      ! compact the array to the real size
      block
         real(kind=real64), dimension(:), allocatable :: compact

         allocate(compact(n))
         compact = arr(:n)
         call move_alloc(from=compact, to=arr)
      end block

      call get_environmenT_variable('OYI_STATS_LABEL', label_buffer, length=length, status=status)

      if (status == 0 .and. length > 0) then
         label = label_buffer(:length)
      else
         label = 'stats'
      end if

      call get_scale_from_env('OYI_STATS_SCALE', scale, scale_used)

      if (scale_used) then
         arr = scale * arr
      end if

      ! calculat the total
      low = 1
      high = size(arr)
      total = recursive_sum(arr, low, high)

      call print_report(values=arr, total=total, label=label, scale=scale)
   end subroutine run_app
end program stats_tool