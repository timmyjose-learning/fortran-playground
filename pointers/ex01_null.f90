program ex01_null
   implicit none

   integer, pointer :: p => null()

   write (*, *) 'p = ', p

   if (.not. associated(p)) then
      write (*, *) 'p is not associated'
   end if
end program ex01_null
