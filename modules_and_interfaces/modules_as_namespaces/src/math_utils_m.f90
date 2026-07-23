module math_utils_m
   implicit none

contains
   integer function square(x)
      implicit none

      integer, intent(in) :: x
      square = x*x
   end function square

   integer function cube(x)
      implicit none

      integer, intent(in) :: x
      cube = x*x*x
   end function cube
end module math_utils_m

