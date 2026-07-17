program ex05_dangling_pointer
   implicit none

   integer, pointer :: p => null()
   integer, pointer :: q => null()

   p = 42
   q => p

   write (*, *) 'p = ', p, ', q = ', q

   deallocate (p)

   ! Segmentation fault
   write (*, *) 'q = ', q
   nullify (q)
end program ex05_dangling_pointer
