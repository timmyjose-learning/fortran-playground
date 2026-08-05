module constants_m
   implicit none
   private

   real, parameter :: PI = 3.141593

   public :: PI
end module constants_m

module shape_m
   use constants_m, only: PI
   implicit none
   private

   type, abstract :: shape_t
   contains
      procedure(area_fn), deferred :: area
   end type shape_t

   abstract interface
      function area_fn(this) result(res)
         import:: shape_t
         implicit none

         class(shape_t), intent(in) :: this
         real :: res
      end function area_fn
   end interface

   type, extends(shape_t) :: circle_t
      private
      real :: radius = 0.0

   contains
      procedure :: area => circle_area
   end type circle_t

   type, extends(shape_t) :: rect_t
      private
      real :: length
      real :: width

   contains
      procedure :: area => rect_area
   end type rect_t

   public :: circle_t, rect_t, make_circle, make_rect

contains
   function make_circle(radius) result(circle)
      implicit none

      real, intent(in) :: radius
      type(circle_t) :: circle

      circle%radius = radius
   end function make_circle

   function make_rect(length, width) result(rect)
      implicit none

      real, intent(in) :: length
      real, intent(in) :: width
      type(rect_t) :: rect

      rect%length = length
      rect%width = width
   end function make_rect

   function circle_area(this) result(area)
      implicit none

      class(circle_t), intent(in) :: this
      real :: area

      area = PI * this%radius**2
   end function circle_area

   function rect_area(this) result(area)
      implicit none

      class(rect_t), intent(in) :: this
      real :: area

      area = this%length * this%width
   end function rect_area
end module shape_m

program oops
   use, intrinsic :: iso_fortran_env, only: output_unit
   use shape_m, only: circle_t, rect_t, make_circle, make_rect
   implicit none

   type(circle_t) :: circle
   type(rect_t) :: rect

   circle = make_circle(10.0)
   rect = make_rect(20.0, 10.0)

   write (output_unit, '("Circle area = ",F8.3)') circle%area()
   write (output_unit, '("Rectangle area = ",F8.3)') rect%area()
end program oops