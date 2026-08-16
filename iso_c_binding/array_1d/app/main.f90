program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use, intrinsic :: iso_c_binding, only: c_int, c_double
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      real(kind=c_double), dimension(5) :: arr = (/ 1.0, 2.0, 3.0, 4.0, 5.0 /)
      integer(kind=c_int) :: n
      real(kind=c_double) :: total

      n = size(arr)
      total = sum(arr, n)

      write (output_unit, '("Sum = ",F8.3)') total
   end subroutine run_app
end program main
