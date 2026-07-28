program ex01_array_constructor
   implicit none

   integer :: i
   integer, dimension(5) :: a

   a = [(i, i=1, 5)]

   write (*, *) a
end program ex01_array_constructor
