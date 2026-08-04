module print_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   interface print_value
      module procedure print_i
      module procedure print_r
      module procedure print_l
   end interface print_value

   public :: print_value
contains
   subroutine print_i(d)
      implicit none

      integer, intent(in) :: d
      write (output_unit, '(I0)') d
   end subroutine print_i

   subroutine print_r(r)
      implicit none

      real, intent(in) :: r
      write (output_unit, '(F10.2)') r
   end subroutine print_r

   subroutine print_l(l)
      implicit none

      logical, intent(in) :: l
      write (output_unit, '(L1)') l
   end subroutine print_l
end module print_m

program generic_procedures
   use print_m, only: print_value
   implicit none

   integer :: d = 42
   real :: r = 2.78128
   logical :: l = .true.

   call print_value(d)
   call print_value(r)
   call print_value(l)
end program generic_procedures