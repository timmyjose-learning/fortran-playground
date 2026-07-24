! This is the Modern Fortran equivalent of the assumed shape demo.
! Modules automatically generate explicit procedure interfaces, so this is better than defining explicit interface susing
! `interface` as in assumed_shape_demo.f90

module array_utils_m
   implicit none

   private

   public :: print_array

contains
   subroutine print_array(a)
      implicit none

      integer, dimension(:), intent(in) :: a
      integer :: i

      do i = 1, size(a)
         write (*, *) a(i)
      end do
   end subroutine print_array
end module array_utils_m

program module_procedure
   use array_utils_m, only: print_array
   implicit none

   integer, dimension(5) :: a = (/1, 2, 3, 4, 5/)
   call print_array(a)
end program module_procedure

