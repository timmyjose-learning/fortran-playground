program explicit_interface_demo
   implicit none

   interface
      subroutine print_square(x)
         implicit none
         integer, intent(in) :: x
      end subroutine print_square
   end interface

   integer :: num

   write (*, *) 'Enter a number'
   read (*, *) num

   call print_square(num)
end program explicit_interface_demo

subroutine print_square(n)
   implicit none

   integer, intent(in) :: n

   write (*, *) n ** 2
end subroutine print_square
