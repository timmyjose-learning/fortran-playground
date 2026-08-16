module demo_m
   use, intrinsic :: iso_c_binding, only: c_char
   implicit none
   private

   interface
      subroutine greet(name) bind(C, name='greet')
         import :: c_char
         implicit none

         character(kind=c_char), dimension(*), intent(in) :: name
      end subroutine greet
   end interface

   public :: greet
end module demo_m
