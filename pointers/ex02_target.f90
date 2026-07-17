program ex02_target
   implicit none

   integer, target :: x
   integer, pointer :: p => null()

   x = 100
   p => x
   write (*, *) 'p = ', p, ' and x = ', x

   p = 99
   write (*, *) 'p = ', p, ' and x = ', x
end program ex02_target
