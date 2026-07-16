module comm_stdlib_demo
   implicit none
   private

   public :: string_demo
contains
   subroutine string_demo
      use stdlib_string_type
      implicit none

      type(string_type) :: string, reversed_string

      write (*, *) 'Enter a string'
      read (*, *) string

      reversed_string = reverse(string)
      write (*, *) reversed_string
   end subroutine string_demo
end module comm_stdlib_demo
