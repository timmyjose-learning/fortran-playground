module constants_m
   implicit none
   private

   real, parameter :: PI = 3.14159

   public :: PI, circle_area

contains
   function circle_area(radius) result(area)
      implicit none

      real, intent(in) :: radius
      real :: area

      area = PI * radius * radius
   end function circle_area
end module constants_m

program ex04_use_demo
   use constants_m, only: PI, circle_area
   implicit none

   real :: radius = 10.0

   write (*, *) 'PI = ', PI
   write (*, *) 'Area = ', circle_area(radius)
end program ex04_use_demo