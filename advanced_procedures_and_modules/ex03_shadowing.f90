program ex03_shadowing
   implicit none

   real :: r = 2.782128

   write (*, *) 'In main, r = ', r
   call demo()
   write (*, *) 'In main, after calling demo,  r = ', r

contains
   subroutine demo()
      implicit none

      ! shadows the host `r` variable
      real :: r = 3.141593

      write (*, *) 'In demo, r = ', r
   end subroutine demo
end program ex03_shadowing

