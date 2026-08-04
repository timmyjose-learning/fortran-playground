module pair_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: pair_t
      private
      integer :: first
      integer :: second

   contains
      procedure, pass(lhs) :: add => add_pair
      procedure, pass(this) :: print => print_pair
      generic :: operator(+) => add
   end type pair_t

   public :: pair_t, make_pair

contains
   function make_pair(f, s) result(p)
      implicit none

      integer, intent(in) :: f, s
      type(pair_t) :: p

      p%first = f
      p%second = s
   end function make_pair

   function add_pair(lhs, rhs) result(sum)
      implicit none

      class(pair_t), intent(in) :: lhs, rhs
      type(pair_t) :: sum

      sum%first = lhs%first + rhs%first
      sum%second = lhs%second + rhs%second
   end function add_pair

   subroutine print_pair(this)
      implicit none

      class(pair_t), intent(in) :: this
      write (output_unit, '("(",I0,",",I0,")")') this%first, this%second
   end subroutine print_pair
end module pair_m

program bound_operator_demo
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use pair_m, only: pair_t, make_pair
   implicit none

   type(pair_t) :: p1, p2
   type(pair_t) :: sum

   integer :: x, y

   write (output_unit, *) 'Enter the first pair'
   read (input_unit, *) x, y

   p1 = make_pair(x, y)

   write (output_unit, *) 'Enter the second pair'
   read (input_unit, *) x, y

   p2 = make_pair(x, y)

   sum = p1 + p2
   call sum%print()
end program bound_operator_demo