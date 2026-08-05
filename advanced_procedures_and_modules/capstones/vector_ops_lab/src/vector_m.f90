module vector_m
   use, intrinsic :: iso_fortran_env, only: real64, output_unit
   implicit none
   private

   type :: vector_t
      real(kind=real64) :: x
      real(kind=real64) :: y
      real(kind=real64) :: z
   end type vector_t

   interface operator(+)
      module procedure add_vectors
   end interface operator(+)

   interface operator(-)
      module procedure sub_vectors
      module procedure negate_vector
   end interface operator(-)

   interface operator(*)
      module procedure vector_times_vector
      module procedure vector_times_scalar
      module procedure scalar_times_vector
   end interface operator(*)

   interface operator(.dot.)
      module procedure dot_product
   end interface operator(.dot.)

   public :: vector_t, print_vector, operator(+), operator(-), operator(*), operator(.dot.), norm

contains
   function norm(v1, v2) result(n)
      implicit none

      type(vector_t), intent(in) :: v1, v2
      real(kind=real64) :: n

      n = sqrt(v1 .dot. v2)
   end function norm

   function dot_product(v1, v2) result(prod)
      implicit none

      type(vector_t), intent(in) :: v1, v2
      real(kind=real64) :: prod

      prod = v1%x * v2%x + v1%y * v2%y + v1%z * v2%z
   end function dot_product

   function scalar_times_vector(s,v) result(prod)
      implicit none

      real(kind=real64), intent(in) :: s
      type(vector_t), intent(in) :: v
      type(vector_t) :: prod

      prod%x = s * v%x
      prod%y = s * v%y
      prod%z = s * v%z
   end function scalar_times_vector

   function vector_times_scalar(v, s) result(prod)
      implicit none

      type(vector_t), intent(in) :: v
      real(kind=real64), intent(in) :: s
      type(vector_t) :: prod

      prod%x = v%x * s
      prod%y = v%y * s
      prod%z = v%z * s
   end function vector_times_scalar

   function vector_times_vector(v1, v2) result(prod)
      implicit none

      type(vector_t), intent(in) :: v1, v2
      type(vector_t) :: prod

      prod%x = v1%y * v2%y + v1%z * v2%z
      prod%y = v1%x * v2%x + v1%z * v2%z
      prod%z = v1%x * v2%x + v1%y * v2%y
   end function vector_times_vector

   function negate_vector(v) result(neg)
      implicit none

      type(vector_t), intent(in) :: v
      type(vector_t) :: neg

      neg%x = -v%x
      neg%y = -v%y
      neg%z = -v%z
   end function negate_vector

   function sub_vectors(v1, v2) result(diff)
      implicit none

      type(vector_t), intent(in) :: v1, v2
      type(vector_t) :: diff

      diff%x = v1%x - v2%x
      diff%y = v1%y - v2%y
      diff%z = v1%z - v2%z
   end function sub_vectors

   function add_vectors(v1, v2) result(sum)
      implicit none

      type(vector_t), intent(in) :: v1, v2
      type(vector_t) :: sum

      sum%x = v1%x + v2%x
      sum%y = v1%y + v2%y
      sum%z = v1%z + v2%z

   end function add_vectors

   subroutine print_vector(vec)
      implicit none

      type(vector_t), intent(in) :: vec
      write (output_unit, '(3(F8.3,","))') vec
   end subroutine print_vector
end module vector_m
