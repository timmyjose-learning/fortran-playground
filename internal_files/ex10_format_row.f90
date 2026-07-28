program ex10_format_row
   implicit none

   integer :: i
   real :: x, y
   character(len=128) :: row

   do i = 1, 5
      x = real(i)
      y = x * x

      write (row, '(I5,2X,F10.3,2X,F10.3)') i, x, y
      write (*, *) row
   end do
end program ex10_format_row