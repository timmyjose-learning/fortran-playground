module shapes_m
   implicit none
   private

   real, parameter :: PI = 3.141593

   type, abstract :: shape_t
   contains
      procedure(unary_fn), deferred :: area
      procedure(unary_fn), deferred :: perimeter
   end type shape_t

   abstract interface
      function unary_fn(this) result(res)
         import :: shape_t
         implicit none

         class(shape_t), intent(in) :: this
         real :: res
      end function unary_fn
   end interface

   type, extends(shape_t) :: circle_t
      private
      real :: radius = 0.0
   contains
      procedure, pass(this) :: area => circle_area
      procedure, pass(this) :: perimeter => circle_perimeter
   end type circle_t

   type, extends(shape_t) :: rect_t
      private
      real :: length = 0.0
      real :: breadth = 0.0
   contains
      procedure, pass(this) :: area => rect_area
      procedure, pass(this) :: perimeter => rect_perimeter
   end type rect_t

   interface
      module function circle_area(this) result(area)
         implicit none

         class(circle_t), intent(in) :: this
         real :: area
      end function circle_area

      module function circle_perimeter(this) result(perimeter)
         implicit none

         class(circle_t), intent(in) :: this
         real :: perimeter
      end function circle_perimeter

      module function rect_area(this) result(area)
         implicit none

         class(rect_t), intent(in) :: this
         real :: area
      end function rect_area

      module function rect_perimeter(this) result(perimeter)
         implicit none

         class(rect_t), intent(in) :: this
         real :: perimeter
      end function rect_perimeter
   end interface

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

      real, intent(in) :: length, breadth
      type(rect_t) :: rect

      rect%length = length
      rect%breadth = breadth
   end function make_rect
end module shapes_m

submodule(shapes_m) shapes_impl_m
   implicit none

contains
   module procedure circle_area
      area = PI * this%radius ** 2
   end procedure circle_area

   module procedure circle_perimeter
      perimeter = 2.0 * PI * this%radius
   end procedure circle_perimeter

   module procedure rect_area
      area = this%length * this%breadth
   end procedure rect_area

   module procedure rect_perimeter
      perimeter = 2.0 * (this%length + this%breadth)
   end procedure rect_perimeter
end submodule shapes_impl_m
