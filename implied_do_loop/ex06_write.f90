program ex06_write
   implicit none

   integer :: i
   integer, dimension(5) :: a

   a = [(i**2, i=1, 5)]

   write (*, *) a
   write (*, *) (a(i), i=1, 5)
   write (*, *) (a(i), i=1, 5, 2)
   write (*, *) (a(i), i=2, 5, 2)
end program ex06_write
