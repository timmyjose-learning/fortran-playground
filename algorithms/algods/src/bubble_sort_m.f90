module bubble_sort_m
   use sort_utils_m, only: int_cmp_fn, swap_int, is_less, is_greater
   implicit none
   private

   public :: bubble_sort

contains
   ! O(n^2) / O(1)
   subroutine bubble_sort(arr, cmp)
      implicit none

      integer, dimension(:), intent(inout) :: arr
      procedure(int_cmp_fn), optional :: cmp
      procedure(int_cmp_fn), pointer :: cmp_func
      integer :: i, j

      if (present(cmp)) then
         cmp_func => cmp
      else
         cmp_func => is_less
      end if

      do i = 1, size(arr)
         do j = 1, size(arr) - 1
            if (cmp_func(arr(j + 1), arr(j))) then
               call swap_int(arr(j + 1), arr(j))
            end if
         end do
      end do
   end subroutine bubble_sort
end module bubble_sort_m
