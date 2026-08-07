module sort_utils_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   abstract interface
      function int_cmp_fn(a, b) result(res)
         implicit none

         integer, intent(in) :: a, b
         logical :: res
      end function int_cmp_fn
   end interface

   public :: int_cmp_fn, swap_int, is_sorted, is_less, is_greater, print_int_array

contains
   function is_less(a, b) result(res)
      implicit none

      integer, intent(in) :: a, b
      logical :: res

      res = a <= b
   end function is_less

   function is_greater(a, b) result(res)
      implicit none

      integer, intent(in) :: a, b
      logical :: res

      res = a >= b
   end function is_greater

   subroutine swap_int(x, y)
      implicit none

      integer, intent(inout) :: x, y
      integer:: temp

      temp = x
      x = y
      y = temp
   end subroutine swap_int

   function is_sorted(arr, cmp) result(sorted)
      implicit none

      integer, dimension(:), intent(in) :: arr
      procedure(int_cmp_fn), optional :: cmp
      procedure(int_cmp_fn), pointer :: comp_func
      logical :: sorted
      integer :: i

      if (present(cmp)) then
         comp_func => cmp
      else
         comp_func => is_less
      end if

      do i = 1, size(arr) - 1
         if (.not. comp_func(arr(i), arr(i + 1))) then
            sorted = .false.
            return
         end if
      end do

      sorted = .true.
   end function is_sorted

   subroutine print_int_array(arr)
      implicit none

      integer, dimension(:), intent(in) :: arr
      integer :: i

      write (output_unit, '("[")', advance='no')
      ! The colon operator avoids putting the separator if there are no more items
      write (output_unit, '(*(I0,:,", "))', advance='no') (arr(i), i = 1, size(arr))
      write (output_unit, '("]")')
   end subroutine print_int_array
end module sort_utils_m
