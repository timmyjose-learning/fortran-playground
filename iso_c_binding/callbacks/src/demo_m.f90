module demo_m
   use, intrinsic :: iso_c_binding, only: c_int, c_funptr
   implicit none

   interface
      function c_apply(a, b, op) bind(C, name='apply') result(res)
         import :: c_int, c_funptr
         implicit none

         integer(kind=c_int), intent(in), value :: a
         integer(kind=c_int), intent(in), value :: b
         type(c_funptr), intent(in), value :: op
         integer(kind=c_int) :: res
      end function c_apply
   end interface

   public :: c_apply

contains
   function add(a, b) bind(C) result(res)
      implicit none

      integer(kind=c_int), intent(in), value :: a, b
      integer(kind=c_int) :: res

      res = a + b
   end function add

   function sub(a, b) bind(C) result(res)
     implicit none

     integer(kind=c_int), intent(in), value :: a, b
     integer(kind=c_int) :: res

     res = a - b
     end function sub
end module demo_m
