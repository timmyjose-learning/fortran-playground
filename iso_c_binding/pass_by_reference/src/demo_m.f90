module demo_m
   use, intrinsic :: iso_c_binding, only: c_int
   implicit none
   private

   interface
      subroutine add_five(x) bind(C, name='add_five')
         import :: c_int
         implicit none

         integer(kind=c_int) :: x
      end subroutine add_five
   end interface

   public :: add_five
end module demo_m
