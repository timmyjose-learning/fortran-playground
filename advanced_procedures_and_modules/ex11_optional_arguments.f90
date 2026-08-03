program ex11_optional_arguments
   implicit none

   call greet('Fred', 'Dr.', .true.)
   call greet('Fred', loud = .true.)
   call greet(name='Fred')

contains
   subroutine greet(name, title, loud)
      implicit none

      character(len=*), intent(in) :: name
      character(len=*), intent(in), optional :: title
      logical, intent(in), optional :: loud

      character(len=:), allocatable :: message

      if (present(title)) then
         message = 'Hello, ' // trim(title) // ' ' // trim(name)
      else
         message = 'Hello, ' // trim(name)
      end if

      if (present(loud)) then
         if (loud) then
            message = message // '!'
         end if
      end if

      write (*, *) message
   end subroutine greet
end program ex11_optional_arguments