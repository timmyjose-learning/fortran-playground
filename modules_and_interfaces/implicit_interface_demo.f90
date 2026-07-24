! Compile the program like so:
! gfortran impliciT_interface_demo.f90 implicit_interface.f90 -o implicit_interface_demo
!
! Avoid implicit interfaces as much as possible since the compiler does not have any useful  type information
! about the `print_square` subroutine at compile time.
program impliciT_interface_demo
   implicit none

   external :: square
   integer :: num

   write (*, *) 'Enter an integer'
   read (*, *) num

   call print_square(num)
end program impliciT_interface_demo
