program ex04_parse_int
   implicit none

   integer :: value
   integer :: iostat
   character(len=256) :: iomsg

   call parse_int("12345", value, iostat, iomsg)
   call report("12345", value, iostat, iomsg)

   call parse_int("hello", value, iostat, iomsg)
   call report("hello", value, iostat, iomsg)

contains
   subroutine parse_int(text, val, status, msg)
      implicit none

      character(len=*), intent(in) :: text
      integer, intent(out) :: val, status
      character(len=*), intent(out) :: msg

      read (text, *, iostat=status, iomsg=msg) val
   end subroutine

   subroutine report(text, val, status, msg)
      implicit none

      character(len=*), intent(in) :: text
      integer, intent(in) :: val, status
      character(len=256), intent(in) :: msg

      if (status /= 0) then
         write (*, *) text, ' => ', msg
      else
         write (*, *) text, ' => ', val
      end if
   end subroutine report
end program ex04_parse_int

