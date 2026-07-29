module error_m
   implicit none
   private

   integer, parameter :: ERR_OK = 0
   integer, parameter :: ERR_IO = 1
   integer, parameter :: ERR_ALLOC = 2
   integer, parameter :: ERR_PARSE = 3

   type :: result_t
      integer :: code = ERR_OK
      character(len=:), allocatable :: msg
   end type result_t

   public :: result_t, ERR_OK, ERR_IO, ERR_ALLOC, ERR_PARSE
end module error_m
