program ex01_int_to_string
   implicit none

   integer :: num
   character(len=32) :: str

   write (*, *) 'Enter an integer'
   read (*, *) num

   write (str, '(I0)') num ! 0 means as many digits as needed
   write (*, '(A,A,A)') '[', trim(str), ']'
end program ex01_int_to_string