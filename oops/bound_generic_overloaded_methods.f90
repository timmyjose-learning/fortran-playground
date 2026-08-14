module string_m
   implicit none
   private

   type :: string_builder_t
      character(len=:), allocatable :: value
   contains
      procedure :: append_char
      procedure :: append_int
      ! generic bound method
      generic :: append => append_char, append_int

      procedure :: to_string
   end type string_builder_t

   private :: append_char, append_int
   public :: string_builder_t

contains
   subroutine append_char(this, char)
      implicit none

      class(string_builder_t), intent(inout) :: this
      character(len=*), intent(in) :: char

      this%value = this%value // char
   end subroutine append_char

   subroutine append_int(this, int)
      implicit none

      class(string_builder_t), intent(inout) :: this
      integer, intent(in) :: int
      character(len=512) :: buffer

      write (buffer, '(I5)') int
      this%value = this%value // trim(adjustl(buffer))
   end subroutine append_int

   function to_string(this) result(value)
      implicit none

      class(string_builder_t), intent(in) :: this
      character(len=:), allocatable :: value

      value = this%value
   end function to_string
end module string_m

program bound_generic_overloaded_methods
   use, intrinsic :: iso_fortran_env, only: output_unit
   use string_m, only: string_builder_t
   implicit none

   call run_app

contains
   subroutine run_app()
      implicit none

      type(string_builder_t) :: sb

      call sb%append('Hello, world!')
      call sb%append(12345)
      write (output_unit, *) sb%to_string()
   end subroutine run_app
end program bound_generic_overloaded_methods