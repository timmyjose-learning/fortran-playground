program ex06_array_slice
   implicit none

   integer, target :: a(5)
   integer, pointer :: p(:) => null()

   a = [1, 2, 3, 4, 5]
   p => a

   write (*, *) 'Is p associated with a? ', associated(p, a)

   write (*, *) p
   p = p*10 ! array operation, applied to each cell of the array
   write (*, *) p

   p => a(2:4)
   write (*, *) p
   p = p/10
   write (*, *) p
end program ex06_array_slice
