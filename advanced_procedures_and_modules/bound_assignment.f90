module string_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: string_t
      character(len=:), allocatable :: str

   contains
      procedure, pass(this) :: assign_char_to_string
      generic :: assignment(=) => assign_char_to_string
      procedure :: print => print_string
   end type string_t

   public :: string_t

contains
   subroutine print_string(this)
      implicit none

      class(string_t), intent(in) :: this

      write (output_unit, '("{ str= ''",A,"'' }")') this%str
   end subroutine print_string

   subroutine assign_char_to_string(this, s)
      implicit none

      class(string_t), intent(inout) :: this
      character(len=*), intent(in) :: s

      this%str = trim(s)
   end subroutine assign_char_to_string
end module string_m

program bound_assignment
   use string_m, only: string_t
   implicit none

   type(string_t) :: str1, str2

   str1 = 'Hello, world!'
   call str1%print()

   ! this work automatically
   str2 = str1
   call str2%print()
end program bound_assignment