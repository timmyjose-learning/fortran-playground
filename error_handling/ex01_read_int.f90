program ex01_read_int
   implicit none

   integer :: d
   integer :: io_status
   character(len=256) :: err_msg

   write (*, *) 'Enter a number'
   read (*, *, iostat=io_status, iomsg=err_msg) d

   if (io_status /= 0) then
      write (*, *) 'Error: ', err_msg
   else
      write (*, *) 'You entered: ', d
   end if
end program ex01_read_int

