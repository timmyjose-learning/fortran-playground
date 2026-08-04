module array_utils_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   public :: print_array

contains
   ! module procedures automatically get explicit interfaces, so using an assumed-shape array argument is
   ! not a problem
   subroutine print_array(arr)
      implicit none

      integer, dimension(:), intent(in) :: arr
      integer :: i

      write (output_unit, '(*(I5))') (arr(i), i = 1, size(arr))
   end subroutine print_array
end module array_utils_m

program modules_automatic_explicit_interfaces_demo
   use array_utils_m , only: print_array
   implicit none

   integer, dimension(7) :: arr = (/ 1, 2, 3, 4, 5, 6, 7 /)

   call print_array(arr)
end program modules_automatic_explicit_interfaces_demo