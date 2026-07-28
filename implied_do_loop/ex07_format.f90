program ex07_format
   implicit none

   integer :: i
   integer :: a(5)

   a = [(10*i, i=1, 5)]

   write (*, *) a
   write (*, '(*(I5))') (a(i), i=1, 5)
   write (*, '(*(I5, 1X))') (a(i), i=1, 5)
   write (*, '(*(I5,2X))') (a(i), i=1, 5)
end program ex07_format
