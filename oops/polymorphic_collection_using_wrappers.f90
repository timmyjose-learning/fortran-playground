module shape_m
   implicit none
   private

   real, parameter :: PI = 3.141593

   type, abstract :: shape_t
   contains
      procedure(area_fn), deferred :: area
      procedure(perimeter_fn), deferred :: perimeter
   end type shape_t

   abstract interface
      function area_fn(this) result(area)
         import :: shape_t
         implicit none

         class(shape_t), intent(in) :: this
         real :: area
      end function area_fn

      function perimeter_fn(this) result(perimeter)
         import :: shape_t
         implicit none

         class(shape_t), intent(in) :: this
         real :: perimeter
      end function perimeter_fn
   end interface

   type, extends(shape_t) :: circle_t
      real :: radius = 0.0
   contains
      procedure :: area => circle_area
      procedure :: perimeter => circle_perimeter
   end type circle_t

   type, extends(shape_t) :: rect_t
      real :: length = 0.0
      real :: breadth = 0.0
   contains
      procedure :: area => rect_area
      procedure :: perimeter => rect_perimeter
   end type rect_t

   public :: shape_t, circle_t, rect_t

contains
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

program polymorphic_collection_using_wrappers
   use, intrinsic :: iso_fortran_env, only: output_unit, error_unit
   use shape_m, only: shape_t, circle_t, rect_t
   implicit none

   type :: boxed_shape_t
      class(shape_t), allocatable :: item
   end type boxed_shape_t

   call run_app()

contains
   subroutine run_app()
      implicit none

      class(boxed_shape_t), dimension(:), allocatable :: shapes
      integer :: stat
      character(len=512) :: errmsg
      integer :: i

      allocate(shapes(2), stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)

      allocate(circle_t :: shapes(1)%item, stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)
      call set_radius(shapes(1)%item, 10.0)

      allocate(rect_t :: shapes(2)%item, stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)
      call set_length_and_breadth(shapes(2)%item, 10.0, 20.0)

      do i = 1, size(shapes)
         write (output_unit, '("Area = ",F8.3,", perimeter = ",F8.3)') shapes(i)%item%area(), shapes(i)%item%perimeter()
      end do
   end subroutine run_app

   subroutine set_radius(shape, radius)
      implicit none
      class(shape_t), intent(inout) :: shape
      real :: radius

      select type (shape)
       type is (circle_t)
         shape%radius = radius
      end select
   end subroutine set_radius

   subroutine set_length_and_breadth(shape, length, breadth)
      implicit none

      class(shape_t), intent(inout) :: shape
      real, intent(in) :: length
      real, intent(in) :: breadth

      select type(shape)
       type is (rect_t)
         shape%length = length
         shape%breadth = breadth
      end select
   end subroutine set_length_and_breadth

   subroutine check_mem(stat, errmsg)
      implicit none

      integer, intent(in) :: stat
      character(len=*), intent(in) :: errmsg

      if (stat /= 0) then
         write (error_unit, *) 'Memory error: ' // errmsg
         error stop
      end if
   end subroutine check_mem
end program polymorphic_collection_using_wrappers