program ex09_2d
   implicit none

   integer :: i, j
   integer, dimension(2, 3) :: a

   do i = 1, size(a, 1)
      do j = 1, size(a, 2)
         a(i, j) = i*j
      end do
   end do

   do i = 1, size(a, 1)
      write (*, '(*(I5, 1X))') (a(i, j), j=1, size(a, 2))
   end do
end program ex09_2d
