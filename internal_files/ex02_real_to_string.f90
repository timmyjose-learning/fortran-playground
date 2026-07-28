program ex02_real_to_string
   implicit none

   real :: pi = 3.141593
   character(len=64) :: str

   write (str, '(F14.6)') pi
   !write (str, '(ES14.6)') pi
   write (*, *) str
end program ex02_real_to_string