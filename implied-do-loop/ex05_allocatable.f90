program ex05_allocatable
   implicit none

   integer :: n, i
   integer, allocatable :: a(:)

   write (*, *) 'Enter the number of values in the array'
   read (*, *) n

   allocate (a(n))

   a = [(10*i, i=1, n)]

   write (*, *) a
end program ex05_allocatable
