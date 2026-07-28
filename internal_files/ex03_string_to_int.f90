program ex03_string_to_int
   implicit none

   character(len=32) :: str
   integer :: num

   write (*, *) 'Enter a number'
   read (*, '(A)') str

   read (str, '(I5)') num
   write (*, '(I5)') num
end program ex03_string_to_int