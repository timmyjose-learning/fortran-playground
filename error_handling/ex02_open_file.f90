program ex02_open_file
   implicit none

   integer :: unit
   integer :: io_status
   character(len=256) :: io_err

   open (newunit=unit, file='missing.txt', status='old', action='read', iostat=io_status, iomsg=io_err)

   if (io_status /= 0) then
      write (*, *) 'Error while opening file'
      write (*, *) trim(io_err)
   end if

   close (unit)
end program ex02_open_file
