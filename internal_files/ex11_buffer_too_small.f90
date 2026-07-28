program ex11_buffer_too_small
   implicit none

   character(len=5) :: buffer
   integer :: iostat
   character(len=512) :: iomsg

   write (buffer, '(I7)', iostat=iostat, iomsg=iomsg) 1234567

   if (iostat /= 0) then
      write (*, *) 'Error: ', iomsg
   else
      write (*, *) buffer
   end if
end program ex11_buffer_too_small