program ex05_parse_dont_trust
   implicit none

   character(len=32) :: line
   integer :: num
   integer :: iostat
   character(len=512) :: iomsg

   read (*, *) line
   read (line, '(I5)', iostat=iostat, iomsg=iomsg) num

   if (iostat /= 0) then
      write (*, *) 'Error while parsing line: ', iomsg
   else
      write (*, *) 'Parsed integer = ', num
   end if
end program ex05_parse_dont_trust
