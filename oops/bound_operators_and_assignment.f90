module vec_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: vec2_t
      private
      real :: x
      real :: y
   contains
      procedure :: print
      procedure :: norm

      procedure :: add_vec2
      generic :: operator(+) => add_vec2

      procedure, pass(lhs) :: scale_right
      procedure, pass(rhs) :: scale_left
      generic :: operator(*) => scale_left, scale_right
   end type vec2_t

   private :: add_vec2, scale_left, scale_right
   public :: vec2_t, make_vec2

contains
   function make_vec2(x, y) result(vec)
      implicit none

      real, intent(in) :: x, y
      type(vec2_t) :: vec

      vec%x = x
      vec%y = y
   end function make_vec2

   subroutine print(this)
      implicit none

      class(vec2_t), intent(in) :: this

      write (output_unit, '("(",F8.3,", ",F8.3,")")') this%x, this%y
   end subroutine print

   function norm(this) result(n)
      implicit none

      class(vec2_t), intent(in) :: this
      real :: n

      n = sqrt(this%x**2 + this%y**2)
   end function norm

   function scale_left(scale, rhs) result(scaled_vec)
      implicit none

      real, intent(in) :: scale
      class(vec2_t), intent(in) :: rhs
      type(vec2_t) :: scaled_vec

      scaled_vec%x = scale * rhs%x
      scaled_vec%y = scale * rhs%y
   end function scale_left

   function scale_right(lhs, scale) result(scaled_vec)
      implicit none

      class(vec2_t), intent(in) :: lhs
      real, intent(in) :: scale
      type(vec2_t) :: scaled_vec

      scaled_vec%x = lhs%x * scale
      scaled_vec%y = lhs%y * scale
   end function scale_right

   function add_vec2(this, that) result(sum)
      implicit none

      class(vec2_t), intent(in) :: this, that
      type(vec2_t) :: sum

      sum%x = this%x + that%x
      sum%y = this%y + that%y
   end function add_vec2
end module vec_m

program bound_operators_and_assignment
   use, intrinsic :: iso_fortran_env, only: output_unit
   use vec_m, only: vec2_t, make_vec2
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(vec2_t) :: a, b, c

      a = make_vec2(1.0, 2.0)
      b = make_vec2(-3.0, 4.0)

      c = 10.0 * (a + b)
      call c%print()

      write (output_unit, *) 'norm(c) = ', c%norm()
   end subroutine run_app
end program bound_operators_and_assignment