module builtin_functions_m
   implicit none
   private

   public :: square, cube, negate

contains
   real function square(r)
      implicit none

      real, intent(in) :: r
      square = r**2
   end function square

   real function cube(r)
      implicit none

      real, intent(in) :: r
      cube = r*r*r
   end function cube

   real function negate(r)
      implicit none

      real, intent(in) :: r
      negate = -r
   end function negate
end module builtin_functions_m
