module string_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: string_box_t
      character(len=:), allocatable :: str
   end type string_box_t

   interface assignment(=)
      module procedure assign_string_to_box
   end interface

   public :: string_box_t, print_string_box, assignment(=)

contains
   subroutine print_string_box(b)
      implicit none

      type(string_box_t), intent(in) :: b

      if (allocated(b%str)) then
         write (output_unit, '("[","str = ",A,"]")') b%str
      else
         write (output_unit, '("[", "str= <unallocated>","]")')
      end if
   end subroutine print_string_box

   subroutine assign_string_to_box(b, s)
      implicit none

      type(string_box_t), intent(inout) :: b
      character(len=*), intent(in) :: s

      b%str = trim(s)
   end subroutine assign_string_to_box
end module string_m

program user_defined_assignment_allocatable
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use string_m, only: string_box_t, print_string_box, assignment(=)
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(string_box_t) :: box, unalloc_box
      character(len=512) :: line

      write (output_unit, *) 'Enter a line'
      read (input_unit, '(A)') line

      box = line
      call print_string_box(box)

      call print_string_box(unalloc_box)
   end subroutine run_app
end program user_defined_assignment_allocatable