module array_utils_m
   implicit none
   private

   public :: alloc_fun_ret_t
   public :: make_countdown
   public :: print_array

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
         real, dimension(:), allocatable, intent(in) :: arr
      end subroutine print_array
   end interface
end module array_utils_m

submodule(array_utils_m) array_utils_impl_m
   implicit none

contains
   module procedure make_countdown
      integer :: stat
      character(len=512) :: errmsg
      integer :: i

      allocate (res%arr(n), stat=stat, errmsg=errmsg)

      if (stat /= 0) then
         write (*, *) 'Error while allocating array: ', errmsg
         error stop
      end if

      do i = 1, size(res%arr)
         res%arr(i) = real(size(res%arr) - i + 1)
      end do
   end procedure make_countdown

   module procedure print_array
      integer :: i

      write (*, '(*(F10.2))') (arr(i), i=1, size(arr))
      write (*, *)
   end procedure print_array
end submodule array_utils_impl_m

program ex02_submodule_allocatable
   use array_utils_m, only: alloc_fun_ret_t, make_countdown, print_array
   implicit none

   type(alloc_fun_ret_t) :: res

   res = make_countdown(10)
   call print_array(res%arr)

   if (allocated(res%arr)) then
      deallocate (res%arr)
   end if
end program ex02_submodule_allocatable
