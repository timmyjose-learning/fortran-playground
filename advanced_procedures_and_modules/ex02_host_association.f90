program ex02_host_association
   implicit none

   real :: factor = 0.25

   call demo()

contains
   subroutine demo()
      implicit none

      real :: r = 100.00

      write (*, *) 'Scaled version = ', factor * r
   end subroutine demo
end program ex02_host_association