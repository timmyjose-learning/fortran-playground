program ex03_assignment
   implicit none

   integer, target :: x, y
   integer, pointer :: p => null()

   x = 10
   y = 20

   p => x

   write (*, *) 'Is p associated with x? ', associated(p, x)
   write (*, *) 'Is p associated with y?', associated(p, y)
   write (*, *) 'p = ', p, ', x = ', x, ', y = ', y

   p = y
   write (*, *) 'Is p associated with x? ', associated(p, x)
   write (*, *) 'Is p associated with y?', associated(p, y)
   write (*, *) 'p = ', p, ', x = ', x, ', y = ', y

   p => y
   write (*, *) 'Is p associated with x? ', associated(p, x)
   write (*, *) 'Is p associated with y?', associated(p, y)
   write (*, *) 'p = ', p, ', x = ', x, ', y = ', y
end program ex03_assignment
