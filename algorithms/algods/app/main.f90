program main
   implicit none

   integer, allocatable :: p

   allocate(p)
   if (allocated(p)) then
      deallocate(p)
   end if

   write (*, *) 'Welcome'
end program main
