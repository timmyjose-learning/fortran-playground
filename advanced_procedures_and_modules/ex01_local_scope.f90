program ex01_local_scope
   implicit none

   integer :: x

   x = 42
   write (*, *) 'In main, x = ', x

   call local_sub()

contains
   subroutine local_sub()
      implicit none

      x = 100
      write (*, *) 'In local_sub, x = ', x
   end subroutine local_sub
end program ex01_local_scope
