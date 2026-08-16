module demo_m
   use, intrinsic :: iso_c_binding, only: c_int
   implicit none
   private

   interface
      subroutine print_x(x) bind(C, name='print_x')
         import :: c_int
         implicit none

         integer(kind=c_int), value :: x
      end subroutine print_x
   end interface

   public :: print_x
end module demo_m
