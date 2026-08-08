program test_linked_list
   use test_helpers_m, only: assert_true
   use linked_list_m, only: list_t
   implicit none

   call run_tests()

contains
   subroutine run_tests()
      implicit none

      call test_empty_list()
      call test_single_element_push_front()
      call test_single_element_push_back()
   end subroutine run_tests

   subroutine test_empty_list()
      implicit none

      type(list_t) :: list

      call assert_true(list%is_empty(), 'test_empty_list')
   end subroutine test_empty_list

   subroutine test_single_element_push_front()
      implicit none

      type(list_t) :: list

      call list%push_front(1)
   end subroutine test_single_element_push_front

   subroutine test_single_element_push_back()
      implicit none
   end subroutine test_single_element_push_back
end program test_linked_list
