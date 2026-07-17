module errors_m
   implicit none

   integer, parameter :: ERR_OK = 0
   integer, parameter :: ERR_PARSE = 1
   integer, parameter :: ERR_ID = 2
   integer, parameter :: ERR_ALLOC = 3
   integer, parameter :: ERR_RANGE = 4

contains
   function error_name(code) result(res)
      implicit none

      integer, intent(in) :: code
      character(len=:), allocatable  :: res

      select case (code)
      case (ERR_OK)
         res = 'ok'
      case (ERR_PARSE)
         res = 'parse error'
      case (ERR_ID)
         res = 'id error'
      case (ERR_ALLOC)
         res = 'allocation error'
      case (ERR_RANGE)
         res = 'range error'
      case default
         res = 'unknown error'
      end select
   end function error_name
end module errors_m

program ex05_error_codes
   use errors_m
   implicit none

   write (*, *) error_name(ERR_ALLOC)
   write (*, *) error_name(ERR_OK)
   write (*, *) error_name(10)
end program ex05_error_codes
