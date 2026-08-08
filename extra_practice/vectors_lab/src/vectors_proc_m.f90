module vectors_proc_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: vector_t
      private
      real :: x
      real :: y
      real :: z
   end type vector_t

   interface
      module subroutine print_vector(vec)
         implicit none
         type(vector_t), intent(in) :: vec
      end subroutine print_vector
   end interface

   interface operator(==)
      module function check_vector_equality(v1, v2) result(eq)
         implicit none
         type(vector_t), intent(in) :: v1, v2
         logical :: eq
      end function check_vector_equality
   end interface operator(==)

   interface operator(+)
      module function add_vectors(v1, v2) result(sum)
         implicit none
         type(vector_t), intent(in) :: v1, v2
         type(vector_t) :: sum
      end function add_vectors
   end interface operator(+)

   interface operator(-)
      module function sub_vectors(v1, v2) result(diff)
         implicit none
         type(vector_t), intent(in) :: v1, v2
         type(vector_t) :: diff
      end function sub_vectors
   end interface operator(-)

   interface operator(*)
      module function vector_times_vector(v1, v2) result(prod)
         implicit none
         type(vector_t), intent(in) :: v1, v2
         type(vector_t) :: prod
      end function vector_times_vector

      module function scalar_times_vector(s, v) result(prod)
         implicit none
         real, intent(in) :: s
         type(vector_t), intent(in) :: v
         type(vector_t) :: prod
      end function scalar_times_vector

      module function vector_times_scalar(v, s) result(prod)
         implicit none
         type(vector_t), intent(in) :: v
         real, intent(in) :: s
         type(vector_t):: prod
      end function vector_times_scalar
   end interface operator(*)

   public :: vector_t, make_vector, print_vector, operator(==), operator(+), &
      operator(-), operator(*)

contains
   function make_vector(x, y, z) result(vec)
      implicit none

      real, intent(in) :: x, y, z
      type(vector_t) :: vec

      vec%x = x
      vec%y = y
      vec%z = z
   end function make_vector
end module vectors_proc_m

submodule(vectors_proc_m) vectors_proc_impl_m
   implicit none

contains
   module procedure print_vector
      write (output_unit, '("(")', advance='no')
      write (output_unit, '(3(F8.3,:,", "))', advance='no') vec%x, vec%y, vec%z
      write (output_unit, '(")")')
   end procedure print_vector

   module procedure check_vector_equality
      eq = v1%x == v2%x .and. v1%y == v2%y .and. v1%z == v2%z
   end procedure check_vector_equality

   module procedure add_vectors
      sum%x = v1%x + v2%x
      sum%y = v1%y + v2%y
      sum%z = v1%z + v2%z
   end procedure add_vectors

   module procedure sub_vectors
      diff%x = v1%x - v2%x
      diff%y = v1%y - v2%y
      diff%z = v1%z - v2%z
   end procedure sub_vectors

   module procedure vector_times_vector
      prod%x = v1%y * v2%y + v1%z * v2%z
      prod%y = v1%x * v2%x + v1%z * v2%z
      prod%z = v1%x * v2%x + v1%y * v2%y
   end procedure vector_times_vector

   module procedure scalar_times_vector
      prod%x = s * v%x
      prod%y = s * v%y
      prod%z = s * v%z
   end procedure scalar_times_vector

   module procedure vector_times_scalar
      prod%x = v%x * s
      prod%y = v%y * s
      prod%z = v%z * s
   end procedure vector_times_scalar
end submodule vectors_proc_impl_m
