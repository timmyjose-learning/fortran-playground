program ex10_read_2d
   implicit none

   integer :: i, j
   integer :: a(2, 3)

   write (*, *) 'Enter 2 rows of 3 numbers each'

   do i = 1, size(a, 1)
      read (*, *) (a(i, j), j=1, size(a, 2))
   end do

   do i = 1, size(a, 1)
      write (*, '(*(I5, 1X))') (a(i, j), j=1, size(a, 2))
   end do
end program ex10_read_2d
