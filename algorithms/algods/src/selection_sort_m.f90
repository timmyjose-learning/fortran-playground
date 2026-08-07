module selection_sort_m
   use sort_utils_m, only: int_cmp_fn, is_less, swap_int
   implicit none
   private

   public :: selection_sort

contains
   subroutine selection_sort(arr, cmp)
      implicit none

      integer, dimension(:), intent(inout) :: arr
      procedure(int_cmp_fn), optional :: cmp
      procedure(int_cmp_fn), pointer :: cmp_func => null()
      integer :: i, j, curr_idx

      if (present(cmp)) then
         cmp_func => cmp
      else
         cmp_func => is_less
      end if


      do i = 1, size(arr) - 1
         curr_idx = i
         do j = i + 1, size(arr)
            if (cmp_func(arr(j), arr(curr_idx))) then
               curr_idx = j
            end if
         end do

         if (curr_idx /= i) then
            call swap_int(arr(i), arr(curr_idx))
         end if
      end do
   end subroutine selection_sort
end module selection_sort_m
