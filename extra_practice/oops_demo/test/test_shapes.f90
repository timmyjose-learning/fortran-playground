program test_shapes
   use, intrinsic :: iso_fortran_env, only: output_unit
   use shapes_m, only: shape_t, circle_t, rect_t, make_circle, make_rect
   implicit none

   call run_tests()

contains
   subroutine run_tests()
      implicit none

      call test_shape()
      call test_circle()
      call test_rectangle()
      call test_circle_concrete()
      call test_rectangle_concrete()
   end subroutine run_tests

   subroutine test_shape()
      implicit none

      class(shape_t), allocatable :: circle
      class(shape_t), allocatable :: rect

      circle = make_circle(10.0)
      write (output_unit, '("[Circle] area =",F8.3,", perimeter = ",F8.3)') circle%area(), circle%perimeter()

      allocate(rect, source=make_rect(10.0, 20.0))
      write (output_unit, '("[Rectangle] area = ",F8.3,", perimeter = ",F8.3)') rect%area(), rect%perimeter()
   end subroutine test_shape

   subroutine test_circle()
      implicit none

      class(shape_t), allocatable :: circle

      allocate(circle, source=make_circle(20.0))
      write (output_unit,*) circle%area(), circle%perimeter()
   end subroutine test_circle

   subroutine test_rectangle()
      implicit none

      class(shape_t), allocatable :: rect

      rect = make_rect(20.0, 30.0)
      write (output_unit, *) rect%area(), rect%perimeter()
   end subroutine test_rectangle

   subroutine test_circle_concrete()
      implicit none

      type(circle_t) :: circle

      circle = make_circle(20.0)
      write (output_unit, *) circle%area(), circle%perimeter()
   end subroutine test_circle_concrete

   subroutine test_rectangle_concrete
      implicit none

      type(rect_t) :: rect

      rect = make_rect(20.0, 30.0)
      write (output_unit, *) rect%area(), rect%perimeter()
   end subroutine test_rectangle_concrete
end program tesT_shapes
