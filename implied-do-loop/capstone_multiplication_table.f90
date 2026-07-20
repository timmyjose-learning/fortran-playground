program capstone_multiplication_table
   implicit none

   integer :: rows, cols
   integer :: i, j
   integer, allocatable :: table(:, :)

   write (*, *) 'Enter the number of rows and columns'
   read (*, *) rows, cols

   allocate (table(rows, cols))

   table = reshape([((i*j, i=1, rows), j=1, cols)], shape(table))

   do i = 1, size(table, 1)
      write (*, '(*(I6))') table(i, :)
   end do
end program capstone_multiplication_table
