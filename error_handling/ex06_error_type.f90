module result_m
   implicit none

   integer, parameter :: ERR_OK = 0
   integer, parameter :: ERR_PARSE = 1
   integer, parameter :: ERR_RANGE = 2

   type :: error_t
      integer :: code = ERR_OK !default value
      character(len=:), allocatable :: msg
   end type error_t

contains
   subroutine ok(err)
      type(error_t), intent(out) :: err

      err%code = ERR_OK
      err%msg = ' '
   end subroutine ok

   subroutine fail(err, code, message)
      implicit none

      type(error_t), intent(out) :: err
      integer :: code
      character(len=*), intent(in) :: message

      err%code = code
      err%msg = message
   end subroutine fail

   logical function failed(err)
      type(error_t), intent(in) :: err

      failed = err%code /= ERR_OK
   end function failed
end module result_m

program ex06_result_type
   use result_m
   implicit none

   type(error_t) :: err
   integer :: x

   call parse_positive_int('42', x, err)
   call show_result(x, err)

   call parse_positive_int('hello', x, err)
   call show_result(x, err)

   call parse_positive_int('-21', x, err)
   call show_result(x, err)

contains
   subroutine parse_positive_int(text, val, err_obj)
      implicit none

      integer :: iostat
      character(len=*), intent(in) :: text
      integer, intent(out) :: val
      type(error_t), intent(out) :: err_obj

      read (text, *, iostat=iostat) val

      if (iostat /= 0) then
         err_obj%code = ERR_PARSE
         err_obj%msg = 'failed to parse integer'
      else if (val <= 0) then
         err_obj%code = ERR_RANGE
         err_obj%msg = 'expected a positive integer'
      end if
   end subroutine parse_positive_int

   subroutine show_result(val, err_obj)
      implicit none

      integer, intent(in) :: val
      type(error_t), intent(in) :: err_obj

      if (failed(err)) then
         write (*, *) 'error: ', err_obj%msg
      else
         write (*, *) 'parsed value = ', val
      end if
   end subroutine show_result
end program ex06_result_type
