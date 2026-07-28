program ex09_parse_key_value
   implicit none

   character(len=128) :: str = 'width = 800'
   character(len=:), allocatable :: key
   character(len=:), allocatable :: value_str
   integer :: eq_pos
   integer :: width
   integer :: iostat

   eq_pos = index(str, '=')

   if (eq_pos == 0) then
      error stop 'need a key = value pair'
   end if

   key = trim(adjustl(str(:eq_pos - 1)))
   value_str = trim(adjustl(str(eq_pos + 1:)))

   if (key == 'width') then
      read (value_str, '(I5)', iostat=iostat) width
      if (iostat /= 0) then
         error stop 'need `width` to be an integer'
      end if
      write (*, '("key = ",A)') key
      write (*, '("width = ",I5)') width
   end if

   if (allocated(key)) deallocate(key)
   if (allocated(value_str)) deallocate(value_str)
end program ex09_parse_key_value