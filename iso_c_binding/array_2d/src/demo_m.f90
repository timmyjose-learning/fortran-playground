module demo_m
   use, intrinsic :: iso_c_binding, only: c_int
   implicit none
   private

   interface
      subroutine print_2d(mat, rows, cols) bind(C, name='print_2d')
         import :: c_int
         implicit none

         integer(kind=c_int), dimension(*), intent(in) :: mat
         integer(kind=c_int), intent(in), value :: rows
         integer(kind=c_int), intent(in), value :: cols
      end subroutine print_2d
   end interface

   public :: print_2d
end module demo_m

