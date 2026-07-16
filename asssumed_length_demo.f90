program assumed_length_demo
   implicit none

   character(len=5) :: string = 'hello'
   ! assumed length also works for parameters
   character(len=*), parameter :: GREETING = 'Howdy!'

   call print_text(string)
   call print_text(GREETING)
end program assumed_length_demo

subroutine print_text(text)
   implicit none

   ! assumed length -> the length is fixed by the string passed into the subroutine
   character(len=*), intent(in) :: text

   write (*, *) 'Text: ', text
   write (*, *) 'Length: ', len(text)
end subroutine print_text
