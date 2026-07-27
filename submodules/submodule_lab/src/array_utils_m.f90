module array_utils_m
   implicit none
   private

   public :: alloc_fun_ret_t, make_countdown, print_array

   type :: alloc_fun_ret_t
      real, allocatable :: arr(:)
   end type alloc_fun_ret_t

   interface
      module function make_countdown(n) result(res)
         implicit none
         integer, intent(in) :: n
         type(alloc_fun_ret_t) :: res
      end function make_countdown

      module subroutine print_array(arr)
         implicit none
         real, dimension(:) :: arr
      end subroutine print_array
   end interface
end module array_utils_m



