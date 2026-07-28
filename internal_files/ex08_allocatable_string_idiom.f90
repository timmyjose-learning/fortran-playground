program ex08_allocatable_string_idiom
   implicit none

   write (*, *) 'id = ' // int_to_string(12345)

contains
   function int_to_string(num) result(str)
      implicit none

      integer, intent(in) :: num
      character(len=:), allocatable :: str
      character(len=32) :: text

      write (text, '(I5)') num
      str = text
   end function int_to_string
end program ex08_allocatable_string_idiom