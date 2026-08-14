module shape_m
   implicit none
   private

   real, parameter :: PI = 3.141593

   type, abstract :: shape_t
   contains
      procedure(area_fn_sig), deferred :: area
      procedure(perimeter_fn_sig), deferred :: perimeter
   end type shape_t

   abstract interface
      function area_fn_sig(this) result(area)
         import :: shape_t
         implicit none

         class(shape_t), intent(in) :: this
         real :: area
      end function area_fn_sig

      function perimeter_fn_sig(this) result(perimeter)
         import :: shape_t
         implicit none

         class(shape_t), intent(in) :: this
         real :: perimeter
      end function perimeter_fn_sig
   end interface

   type, extends(shape_t) :: circle_t
      private
      real :: radius = 0.0
   contains
      procedure :: area => circle_area
      procedure :: perimeter => circle_perimeter
   end type circle_t

   type, extends(shape_t) :: rect_t
      private
      real :: length = 0.0
      real :: breadth = 0.0
   contains
      procedure :: area => rect_area
      procedure :: perimeter => rect_perimeter
   end type rect_t

   public :: shape_t, circle_t, rect_t, make_circle, make_rect

contains
   function make_circle(radius) result(circle)
      implicit none

      real, intent(in) :: radius
      type(circle_t) :: circle

      circle%radius = radius
   end function make_circle

   function make_rect(length, breadth) result(rect)
      implicit none

      real, intent(in) :: length
      real, intent(in) :: breadth
      type(rect_t) :: rect

      rect%length = length
      rect%breadth = breadth
   end function make_rect

   function circle_area(this) result(area)
      implicit none

      class(circle_t), intent(in) :: this
      real :: area

      area = PI * this%radius**2
   end function circle_area

   function circle_perimeter(this) result(perimeter)
      implicit none

      class(circle_t), intent(in) :: this
      real :: perimeter

      perimeter = 2.0 * PI * this%radius
   end function circle_perimeter

   function rect_area(this) result(area)
      implicit none

      class(rect_t), intent(in) :: this
      real :: area

      area = this%length * this%breadth
   end function rect_area

   function rect_perimeter(this) result(perimeter)
      implicit none

      class(rect_t), intent(in) :: this
      real :: perimeter

      perimeter = 2.0 * (this%length + this%breadth)
   end function rect_perimeter
end module shape_m

program abstract_type_and_deferred
   use, intrinsic :: iso_fortran_env, only: output_unit
   use shape_m, only: shape_t, circle_t, rect_t, make_circle, make_rect
   implicit none

   call run_app

contains
   subroutine run_app()
      implicit none

      class(shape_t), pointer :: shape
      type(circle_t), target :: circle
      type(rect_t), target :: rect

      circle = make_circle(10.0)
      shape => circle
      write (output_unit, '("[Circle] area = ",F8.3, ", perimeter = ",F8.3)') shape%area(), shape%perimeter()

      rect = make_rect(10.0, 20.0)
      shape => rect
      write (output_unit, '("[Rectangle] area = ",F8.3, ", perimeter = ",F8.3)') shape%area(), shape%perimeter()
   end subroutine run_app
end program abstract_type_and_deferred