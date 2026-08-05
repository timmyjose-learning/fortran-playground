module vector_m
   use, intrinsic :: iso_fortran_env, only: real64, output_unit
   implicit none
   private

   type :: vector_t
      private
      real(kind=real64) :: x
      real(kind=real64) :: y
      real(kind=real64) :: z

   contains
      procedure, pass(this) :: print => print_vector

      procedure, pass(this) :: add =>  add_vectors
      generic :: operator(+) => add

      procedure, pass(this) :: sub => sub_vectors, negate
      generic :: operator(-) => sub, negate

      procedure, pass(this) :: mul_vectors,  scalar_times_vector,  vector_times_scalar
      generic :: operator(*) => mul_vectors, scalar_times_vector, vector_times_scalar

      procedure, pass(this) :: dot => dot_product
      generic :: operator(.dot.) => dot
   end type vector_t

   public :: vector_t, make_vector, norm

contains
   function norm(this, other) result(n)
      implicit none

      class(vector_t), intent(in) :: this, other
      real(kind=real64) :: n

      n = sqrt(this .dot. other)
   end function norm

   function dot_product(this, other) result(prod)
      implicit none

      class(vector_t), intent(in) :: this, other
      real(kind=real64) :: prod

      prod = this%x * other%x + this%y * other%y + this%z * other%z
   end function dot_product

   function vector_times_scalar(this, s) result(prod)
      implicit none

      class(vector_t), intent(in) :: this
      real(kind=real64), intent(in) :: s
      type(vector_t) :: prod

      prod%x = this%x * s
      prod%y = this%y * s
      prod%z = this%z * s
   end function vector_times_scalar

   function scalar_times_vector(s, this) result(prod)
      implicit none

      real(kind=real64), intent(in) :: s
      class(vector_t), intent(in) :: this
      type(vector_t) :: prod

      prod%x = s * this%x
      prod%y = s * this%y
      prod%z = s * this%z
   end function scalar_times_vector

   function mul_vectors(this, other) result(prod)
      implicit none

      class(vector_t), intent(in) :: this, other
      type(vector_t) :: prod

      prod%x = this%y * other%y + this%z * other%z
      prod%y = this%x * other%x + this%z * other%z
      prod%z = this%x * other%x + this%y * other%y
   end function mul_vectors

   function negate(this) result(neg)
      implicit none

      class(vector_t), intent(in) :: this
      type(vector_t) :: neg

      neg%x = -this%x
      neg%y = -this%y
      neg%z = -this%z
   end function negate

   function sub_vectors(this, other) result(diff)
      implicit none

      class(vector_t), intent(in) :: this, other
      type(vector_t) :: diff

      diff%x = this%x - other%x
      diff%y = this%y - other%y
      diff%z = this%z - other%z
   end function sub_vectors

   function add_vectors(this, other) result(sum)
      implicit none

      class(vector_t), intent(in) :: this, other
      type(vector_t) :: sum

      sum%x = this%x + other%x
      sum%y = this%y + other%y
      sum%z = this%z + other%z
   end function add_vectors

   subroutine print_vector(this)
      implicit none

      class(vector_t), intent(in) :: this

      write (output_unit, '("(",F8.3,",",F8.3,",",F8.3,")")') this%x, this%y, this%z
   end subroutine print_vector

   function make_vector(x, y, z) result(vec)
      implicit none

      real(kind=real64), intent(in) :: x, y, z
      type(vector_t) :: vec

      vec%x = x
      vec%y = y
      vec%z = z
   end function make_vector
end module vector_m
