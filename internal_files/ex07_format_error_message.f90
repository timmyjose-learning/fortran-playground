program ex07_format_error_message
   implicit none

   integer :: line_no
   character(len=128) :: message

   line_no = 42
   write (message, '("line ", I0, ": expected integer")') line_no
   write (*, *) trim(message)
end program ex07_format_error_message