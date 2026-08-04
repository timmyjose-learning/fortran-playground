subroutine double(x)
   implicit none

   integer, intent(inout) :: x

   x = 2 * x
end subroutine double

program implicit_interface_demo
   implicit none

   integer :: num

   write (*, *) 'Enter a number'
   read (*, *) num

   ! implicit interface - weak typing
   call double(num)

   write (*, *) num
end program implicit_interface_demo
