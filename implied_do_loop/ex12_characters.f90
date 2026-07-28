program ex12_characters
   implicit none

   integer :: i
   character(len=1) :: a(5)

   a = [(achar(iachar('A') + i - 1), i=1, 5)]
   write (*, '(*(A1,1X))') a
end program ex12_characters
