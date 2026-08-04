module box_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: int_box_t
      integer :: val = 0
   end type int_box_t

   interface assignment(=)
      module procedure assign_int_to_box
   end interface

   public :: int_box_t, print_box, assignment(=)

contains
   subroutine print_box(b)
      implicit none
      type(int_box_t), intent(in) :: b

      write (output_unit, *) b%val
   end subroutine print_box

   subroutine assign_int_to_box(b, d)
      implicit none

      type(int_box_t), intent(inout) :: b
      integer, intent(in) :: d

      b%val = d
   end subroutine assign_int_to_box
end module box_m

program user_defined_assignment
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use box_m, only: int_box_t, print_box, assignment(=)
   implicit none

   type(int_box_t) :: box
   integer :: d

   write (output_unit, *) 'Enter a number'
   read (input_unit, *) d

   box = d
   call print_box(box)
end program user_defined_assignment
