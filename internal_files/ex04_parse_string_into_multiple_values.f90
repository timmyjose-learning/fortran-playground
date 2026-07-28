program ex04_parse_string_into_multiple_values
   implicit none

   character(len=128) :: text
   integer :: a
   real :: b
   logical :: c

   text = '12345 2.71828 .true.'
   read (text, *) a, b, c

   write (*, *) a, b, c
end program ex04_parse_string_into_multiple_values