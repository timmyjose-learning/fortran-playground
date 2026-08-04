module swap_m
   implicit none
   private

   interface swap
      module procedure swap_int
      module procedure swap_real
      module procedure swap_logical
   end interface swap

   public :: swap

contains
   subroutine swap_int(d1, d2)
      implicit none

      integer, intent(inout) :: d1, d2
      integer :: temp

      temp = d1
      d1 = d2
      d2 = temp
   end subroutine swap_int

   subroutine swap_real(r1, r2)
      implicit none

      real, intent(inout) :: r1, r2
      real :: temp

      temp = r1
      r1 = r2
      r2 = temp
   end subroutine swap_real

   subroutine swap_logical(l1, l2)
      implicit none

      logical, intent(inout) :: l1, l2
      logical :: temp

      temp = l1
      l1 = l2
      l2 = temp
   end subroutine swap_logical
end module swap_m

program generic_swap
   use, intrinsic :: iso_fortran_env, only: output_unit
   use swap_m, only: swap
   implicit none

   integer :: d1, d2
   real :: r1, r2
   logical :: l1, l2

   d1 = 42
   d2 = 21
   r1 = 2.78128
   r2 = 3.141593
   l1 = .true.
   l2 = .false.

   write (output_unit, *) 'Before swap, d1 = ', d1, ', d2 = ', d2
   call swap(d1, d2)
   write (output_unit, *) 'After swap, d1 = ', d1, ', d2 = ', d2

   write (output_unit, *) 'Before swap, r1 = ', r1, ', r2 = ', r2
   call swap(r1, r2)
   write (output_unit, *) 'After swap, r1 = ', r1, ', r2 = ', r2

   write (output_unit, *) 'Before swap, l1 = ', l1, ', l2 = ', l2
   call swap(l1, l2)
   write (output_unit, *) 'After swap, l1 = ', l1, ', l2 = ', l2
end program generic_swap