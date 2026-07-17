program ex04_allocate
   implicit none

   integer, pointer :: p => null()

   write (*, *) 'Is p associated? ', associated(p) ! F

   allocate (p)

   write (*, *) 'Is p associated? ', associated(p) ! T

   p = 42
   write (*, *) 'p = ', p

   deallocate (p)
   write (*, *) 'Is p associated? ', associated(p) ! T

   nullify (p)
   write (*, *) 'Is p associated? ', associated(p) ! T
end program ex04_allocate
