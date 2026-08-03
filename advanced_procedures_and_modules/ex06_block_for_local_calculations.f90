program ex06_block_for_local_calculations
   implicit none

   integer :: result

   block
      integer :: temp = 42

      result = temp * 100
   end block

   write (*, *) 'result = ', result
end program ex06_block_for_local_calculations