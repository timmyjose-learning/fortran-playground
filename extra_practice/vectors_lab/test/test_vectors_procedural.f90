program test_vectors_procedural
   use test_helpers_m, only: assert_true, assert_false
   use vectors_proc_m, only: vector_t, make_vector, print_vector, operator(==), &
      operator(+), operator(-), operator(*)
   implicit none

   call run_tests()

contains
   subroutine run_tests()
      implicit none

      call test_creation()
      call test_equality()
      call test_addition()
      call test_subtraction()
      call test_multiplication()
   end subroutine run_tests

   subroutine test_creation()
      implicit none

      type(vector_t) :: vec

      vec = make_vector(1.0, 2.0, 3.0)
      call print_vector(vec)
   end subroutine test_creation

   subroutine test_equality()
      implicit none

      type(vector_t) :: v1, v2, v3

      v1 = make_vector(1.0, 2.0, 3.0)
      v2 = make_vector(1.0, 2.0, 3.0)
      call assert_true(v1 == v2)

      v3 = make_vector(1.1, 2.0, 3.0)
      call assert_false(v1 == v3, 'test_equality')
   end subroutine test_equality

   subroutine test_addition()
      implicit none

      type(vector_t) :: v1, v2
      type(vector_t) :: sum

      v1 = make_vector(1.0, 2.0, 3.0)
      v2 = make_vector(2.0, -1.0, -2.0)

      sum = v1 + v2
      call assert_true (sum == make_vector(3.0, 1.0, 1.0))
   end subroutine test_addition

   subroutine test_subtraction()
      implicit none

      type(vector_t) :: v1, v2
      type(vector_t) :: diff

      v1 = make_vector(1.0, 2.0, 3.0)
      v2 = make_vector(2.0, 3.0, 4.0)

      diff = v1 - v2
      call assert_true (diff == make_vector(-1.0, -1.0, -1.0))

      diff = v2 - v1
      call assert_true (diff == make_vector (1.0, 1.0, 1.0))
   end subroutine test_subtraction

   subroutine test_multiplication()
      implicit none

      type(vector_t) :: v1, v2
      type(vector_t) :: prod

      v1 = make_vector(1.0, 2.0, 3.0)
      v2 = make_vector(2.0, 3.0, 4.0)

      prod = v1 * v2
      call assert_true (prod == make_vector(18.0, 14.0, 8.0))

      prod = 2.0 * v1
      call assert_true (prod == make_vector(2.0, 4.0, 6.0))

      prod = v2 * 2.0
      call assert_true (prod == make_vector(4.0, 6.0, 8.0))
   end subroutine test_multiplication
end program test_vectors_procedural

