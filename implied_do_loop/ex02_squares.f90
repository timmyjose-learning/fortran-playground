program ex02_squares
   implicit none

   integer :: i
   integer :: a(5)

   a = [(i*i, i=1, 5)]
   write (*, *) a
end program ex02_squares
