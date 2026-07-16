! deferred length implies truly dynamic strings and must always be used with `allocatable` or `pointer` attributes
program deferred_length_demo
   implicit none

   character(len=:), allocatable :: dynamic_str

   dynamic_str = 'Hello'
   call print_text(dynamic_str)

   dynamic_str = 'This is a test'
   call print_text(dynamic_str)

   deallocate (dynamic_str)

   ! we can also explicitly allocate deferred length strings
   allocate (character(len=50) :: dynamic_str)
   dynamic_str = 'Hello, world!'

   deallocate (dynamic_str)
end program deferred_length_demo

subroutine print_text(text)
   implicit none

   character(len=*), intent(in) :: text

   write (*, *) 'Text = ', text
   write (*, *) 'Length = ', len(text)
end subroutine print_text
