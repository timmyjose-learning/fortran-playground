program ex07_block_allocatable
   implicit none

   block
      integer, dimension(:), allocatable :: arr

      arr = [1, 2, 3, 4, 5]
      write (*, *) sum(arr)
   end block

   write (*, *) 'After the block'
end program ex07_block_allocatable