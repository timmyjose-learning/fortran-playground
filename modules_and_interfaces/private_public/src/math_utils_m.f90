module math_utils_m
   implicit none
   private

   type :: math_result_t
      integer :: sum
      integer :: diff
      integer :: prod
      integer :: quot
   end type math_result_t

   public :: math_result_t, calculate

contains
   integer function add(x, y)
      implicit none

      integer, intent(in) :: x, y
      add = x + y
   end function add

   integer function sub(x, y)
      implicit none

      integer, intent(in) :: x, y
      sub = x - y
   end function sub

   integer function mul(x, y)
      implicit none

      integer, intent(in) :: x, y
      mul = x*y
   end function mul

   integer function div(x, y)
      implicit none

      integer, intent(in) :: x, y

      if (y == 0) then
         div = 0
      else
         div = x/y
      end if
   end function div

   type(math_result_t) function calculate(x, y) result(res)
      implicit none

      integer, intent(in) :: x, y

      res%sum = add(x, y)
      res%diff = sub(x, y)
      res%prod = mul(x, y)
      res%quot = div(x, y)
   end function calculate
end module math_utils_m
