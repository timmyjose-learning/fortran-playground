program init_ten_minus
   implicit none

   integer :: i
   integer :: a(5)

   a = [(10 - i, i=1, 5)]
   write (*, *) a
end program init_ten_minus
