program test_bubble_sort
   use test_helpers_m, only: assert_true, assert_false
   use sort_utils_m, only: is_sorted, is_greater, print_int_array
   use bubble_sort_m, only: bubble_sort
   implicit none

   call test()

contains
   subroutine test()
      implicit none

      call test_empty_trivially_sorted()
      call test_is_sorted_asc()
      call test_is_sorted_desc()
   end subroutine test

   subroutine test_empty_trivially_sorted()
      implicit none

      integer, dimension(0) :: arr

      call assert_true(is_sorted(arr))
   end subroutine test_empty_trivially_sorted

   subroutine test_is_sorted_asc()
      implicit none

      integer, dimension(10) :: arr = [1, 0, -1, -1, 10, 89, 88, -88, 0, 12]

      call assert_false(is_sorted(arr), 'test_is_sorted_asc')
      call bubble_sort(arr)
      call assert_true (is_sorted(arr), 'test_is_sorted_asc')
   end subroutine test_is_sorted_asc

   subroutine test_is_sorted_desc()
      implicit none

      integer, dimension(10) :: arr = [1, 0, -1, -1, 10, 89, 88, -88, 0, 12]

      call assert_false(is_sorted(arr), 'test_is_sorted_desc')
      call bubble_sort(arr, cmp=is_greater)
      call assert_true (is_sorted(arr, cmp=is_greater), 'test_is_sorted_desc')
   end subroutine test_is_sorted_desc
end program test_bubble_sort
