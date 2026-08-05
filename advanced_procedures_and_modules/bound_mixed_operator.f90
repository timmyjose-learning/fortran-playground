module pair_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: pair_t
      private
      real :: x
      real :: y

   contains
      procedure, pass(lhs) :: pair_times_scalar
      procedure, pass(rhs) :: scalar_times_pair
      generic :: operator(*) => pair_times_scalar, scalar_times_pair
      procedure :: print => print_pair
   end type pair_t

   public :: pair_t, make_pair

contains
   function make_pair(x, y) result(p)
      implicit none

      real, intent(in) :: x, y
      type(pair_t) :: p

      p%x = x
      p%y = y
   end function make_pair

   function pair_times_scalar(lhs, s) result(prod)
      implicit none

      class(pair_t), intent(in) :: lhs
      real, intent(in) :: s
      type(pair_t) :: prod

      prod%x = lhs%x * s
      prod%y = lhs%y * s
   end function pair_times_scalar

   function scalar_times_pair(s, rhs) result(prod)
      implicit none

      real, intent(in) :: s
      class(pair_t), intent(in) :: rhs
      type(pair_t) :: prod

      prod%x = s * rhs%x
      prod%y = s * rhs%y
   end function scalar_times_pair

   subroutine print_pair(this)
      implicit none

      class(pair_t), intent(in) :: this

      write (output_unit, '("(",F8.3,", ",F8.3,")")') this%x, this%y
   end subroutine print_pair
end module pair_m

program bound_mixed_operator
   use pair_m, only: pair_t, make_pair
   implicit none

   type(pair_t) :: p1, p2, p3
   real :: s = 2.5

   p1 = make_pair(1.0, 2.0)
   call p1%print()

   p2 = p1 * s
   call p2%print()

   p3 = s * p1
   call p3%print()
end program bound_mixed_operator