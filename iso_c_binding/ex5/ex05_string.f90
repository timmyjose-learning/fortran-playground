program ex05_string
   use, intrinsic :: iso_c_binding, only: c_char, c_null_char
   implicit none

   interface
      subroutine c_print_string(s) bind(C, name='c_print_string')
         import :: c_char

         character(kind=c_char), intent(in) :: s(*)
      end subroutine c_print_string
   end interface

   character(kind=c_char) :: msg(6) = [character(kind=c_char) ::['H', 'e', 'l', 'l', 'o', c_null_char]]
   call c_print_string(msg)
end program ex05_string
