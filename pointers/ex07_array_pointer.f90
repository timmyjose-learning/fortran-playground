program ex07_array_pointer
   implicit none

   integer, pointer :: p(:) => null()
   integer :: idx

   allocate (p(5))

   do idx = 1, 5
      p(idx) = idx*100
   end do

   write (*, *) p

   deallocate (p)
   nullify (p)
end program ex07_array_pointer

