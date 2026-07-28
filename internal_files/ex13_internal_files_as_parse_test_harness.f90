program ex13_internal_files_as_parse_test_harness
   implicit none

   call test_parse_int('12345', 12345)
   call test_parse_int('-99', -99)
   call test_parse_failure('hello')

contains
   function parse_int(text, num) result(ok)
      implicit none

      character(len=*), intent(in) :: text
      integer, intent(out) :: num
      logical :: ok
      integer :: iostat

      read (text, '(I5)', iostat=iostat) num

      if (iostat /= 0) then
         ok = .false.
      else
         ok = .true.
      end if
   end function parse_int

   subroutine test_parse_int(text, expected)
      implicit none

      character(len=*), intent(in) :: text
      integer, intent(in) :: expected
      integer :: actual
      logical :: ok

      ok = parse_int(text, actual)

      if (.not. ok) then
         error stop 'expected an integer'
      end if

      if (actual /= expected) then
         write (*, *) 'expected: ', expected, ', got ', actual
         error stop
      end if

      write (*, *) 'test_parse_int passed'
   end subroutine test_parse_int

   subroutine test_parse_failure(text)
      implicit none

      character(len=*), intent(in) :: text
      integer :: dummy

      if (parse_int(text, dummy)) then
         error stop 'expected failure'
      end if

      write (*, *) 'test_parse_failure passed'
   end subroutine test_parse_failure
end program ex13_internal_files_as_parse_test_harness