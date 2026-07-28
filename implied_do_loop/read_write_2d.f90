program read_write_2d
   implicit none

   integer :: i, j
   integer :: a(3, 5)

   do i = 1, size(a, 1)
      read (*, *) (a(i, j), j=1, size(a, 2))
   end do

   do i = 1, size(a, 1)
      write (*, '(*(I5, 1X))') (a(i, j), j=1, size(a, 2))
   end do
end program read_write_2d
