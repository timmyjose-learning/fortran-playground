module insertion_sort_m
   use sort_utils_m, only: int_cmp_fn, is_less, swap_int
   implicit none
   private

   public :: insertion_sort

contains
   subroutine insertion_sort(arr, cmp)
      implicit none

      integer, dimension(:), intent(inout) :: arr
      procedure(int_cmp_fn), optional :: cmp
      procedure(int_cmp_fn), pointer :: cmp_func => null()
      integer :: i, j
      integer :: key

      if (present(cmp)) then
         cmp_func => cmp
      else
         cmp_func => is_less
      end if

      do i = 2, size(arr)
         key = arr(i)
         j = i - 1
         ! no short-circuiting in Fortran!
         do while (cmp_func(key, arr(j)))
            arr(j + 1) = arr(j)
            j = j - 1
            if (j < 1) exit
         end do
         arr(j + 1) = key
      end do
   end subroutine insertion_sort
end module insertion_sort_m
