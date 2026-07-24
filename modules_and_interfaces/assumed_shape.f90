subroutine assumed_shape(a)
   implicit none

   integer, intent(in) :: a(:)
   integer :: i

   do i = 1, size(a)
      write (*, *) a(i)
   end do
end subroutine assumed_shape
