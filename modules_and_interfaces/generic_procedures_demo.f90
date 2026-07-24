! The `interface` keyword is used to allow defining generic procedures by making use
! of module procedures. Based on the type of the input, the correct implementation is picked
! by the compiler

module swap_utils_m
   implicit none
   private

   type :: int_wrapper_t
      integer :: ival
   end type int_wrapper_t

   ! generic procedures achieved using `interface` and `module procedure`
   interface swap
      module procedure swap_int
      module procedure swap_real
      module procedure swap_int_wrapper_t
   end interface

   public :: swap, int_wrapper_t

contains
   subroutine swap_int(x, y)
      implicit none

      integer, intent(inout) :: x, y
      integer :: temp

      temp = x
      x = y
      y = temp
   end subroutine swap_int

   subroutine swap_real(x, y)
      implicit none

      real, intent(inout) :: x, y
      real :: temp

      temp = x
      x = y
      y = temp
   end subroutine swap_real

   subroutine swap_int_wrapper_t(x, y)
      implicit none

      type(int_wrapper_t), intent(inout) :: x, y
      integer :: temp

      temp = x%ival
      x%ival = y%ival
      y%ival = temp
   end subroutine swap_int_wrapper_t
end module swap_utils_m

program generic_procedures_demo
   use swap_utils_m, only: int_wrapper_t, swap
   implicit none

   integer :: a = 1, b = 2
   real :: x = 3.141593, y = 2.7828
   type(int_wrapper_t) :: ia, ib

   ia%ival = 42
   ib%ival = 21

   write (*, *) 'Before swapping, a = ', a, ' and b = ', b
   call swap(a, b)
   write (*, *) 'After swapping, a = ', a, ' and b = ', b

   write (*, *) 'Before swapping, x = ', x, ' and y = ', y
   call swap(x, y)
   write (*, *) 'After swapping, x = ', x, ' and y = ', y

   write (*, *) 'Before swapping, ia = ', ia, ' and ib = ', ib
   call swap(ia, ib)
   write (*, *) 'After swapping, ia = ', ia, ' and ib = ', ib
end program generic_procedures_demo

