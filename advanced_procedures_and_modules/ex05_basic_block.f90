program ex05_basic_block
   implicit none

   integer :: x = 42

   write (*, *) 'Outside the block, x = ', x

   block
      integer :: x = 100

      write (*, *) 'Inside the block, x = ', x
   end block

   write (*, *) 'Outside the block again, x = ', x
end program ex05_basic_block