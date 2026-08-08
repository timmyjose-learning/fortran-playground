module test_helpers_m
   use, intrinsic :: iso_fortran_env, only: error_unit
   implicit none
   private

   public :: assert_true, assert_false

contains
   subroutine assert_true(ok, message)
      implicit none

      logical, intent(in) :: ok
      character(len=*), intent(in), optional :: message

      if (.not. ok) then
         if (present(message)) then
            write (error_unit, *) 'Assertion failed: ' // message
         else
            write (error_unit, *) 'Assertion failed'
         end if
      end if
   end subroutine assert_true

   subroutine assert_false(ok, message)
      implicit none

      logical, intent(in) :: ok
      character(len=*), intent(in), optional :: message

      call assert_true(.not. ok, message)
   end subroutine assert_false
end module test_helpers_m
