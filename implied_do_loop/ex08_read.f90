program ex08_read
   implicit none

   integer :: i
   integer, dimension(5) :: a

   write (*, *) 'Enter 5 values'
   read (*, *) (a(i), i=1, 5)

   write (*, *) 'You entered'
   write (*, '(*(I5, 1X))') (a(i), i=1, 5)
end program ex08_read
