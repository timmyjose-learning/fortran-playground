program init_double_array
   implicit none

   integer :: i
   integer, dimension(5) :: a

   a = [(2*i, i=1, 5)]
   write (*, *) a
end program init_double_array
