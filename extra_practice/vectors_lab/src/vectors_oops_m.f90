module vectors_oops_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: vector_t
      private
      real :: x
      real :: y
      real :: z

   contains
      procedure, pass(this) :: print => print_vector

      procedure, pass(this) :: check_vector_equality
      generic :: operator(==) => check_vector_equality

      procedure, pass(this) :: vector_plus_vector
      generic :: operator(+) => vector_plus_vector

      procedure, pass(this) :: vector_minus_vector
      generic :: operator(-) => vector_minus_vector

      procedure, pass(this) :: vector_times_vector, scalar_times_vector, vector_times_scalar
      generic :: operator(*) => vector_times_vector, scalar_times_vector, vector_times_scalar
   end type vector_t

   interface
      module subroutine print_vector(this)
         implicit none
         class(vector_t), intent(in) :: this
      end subroutine print_vector

      module function check_vector_equality(this, that) result(ok)
         implicit none
         class(vector_t), intent(in) :: this, that
         logical :: ok
      end function check_vector_equality

      module function vector_plus_vector(this, that) result(sum)
         implicit none

         class(vector_t), intent(in) :: this, that
         type(vector_t) :: sum
      end function vector_plus_vector

      module function vector_minus_vector(this, that) result(diff)
         implicit none
         class(vector_t), intent(in) :: this, that
         type(vector_t) :: diff
      end function vector_minus_vector

      module function vector_times_vector(this, that) result(prod)
         implicit none
         class(vector_t), intent(in) :: this, that
         type(vector_t) :: prod
      end function vector_times_vector

      module function scalar_times_vector(s, this) result(prod)
         implicit none
         real, intent(in) :: s
         class(vector_t), intent(in) :: this
         type(vector_t) :: prod
      end function scalar_times_vector

      module function vector_times_scalar(this, s) result(prod)
         implicit none
         class(vector_t), intent(in) :: this
         real, intent(in) :: s
         type(vector_t) :: prod
      end function vector_times_scalar
   end interface

   public :: vector_t, make_vector

contains
   function make_vector(x, y, z) result(vec)
      implicit none

      real, intent(in) :: x, y, z
      type(vector_t) :: vec

      vec%x = x
      vec%y = y
      vec%z = z
   end function make_vector
end module vectors_oops_m

submodule(vectors_oops_m) vectors_oops_impl_m
   implicit none

contains
   module procedure print_vector
      write (output_unit, '("(")', advance='no')
      write (output_unit, '(3(F8.3,:,","))', advance='no') this%x, this%y, this%z
      write (output_unit, '(")")')
   end procedure print_vector

   module procedure check_vector_equality
      ok = this%x == that %x .and. this%y == that%y .and. this%z == that%z
   end procedure check_vector_equality

   module procedure vector_plus_vector
      sum%x = this%x + that%x
      sum%y = this%y + that%y
      sum%z = this%z + that%z
   end procedure vector_plus_vector

   module procedure vector_minus_vector
      diff%x = this%x - that%x
      diff%y = this%y - that%y
      diff%z = this%z - that%z
   end procedure vector_minus_vector

   module procedure vector_times_vector
      prod%x = this%y * that%y + this%z * that%z
      prod%y = this%x * that%x + this%z * that%z
      prod%z = this%x * that%x + this%y * that%y
   end procedure vector_times_vector

   module procedure scalar_times_vector
      prod%x = s * this%x
      prod%y = s * this%y
      prod%z = s * this%z
   end procedure scalar_times_vector

   module procedure vector_times_scalar
      prod%x = this%x * s
      prod%y = this%y * s
      prod%z = this%z * s
   end procedure vector_times_scalar
end submodule vectors_oops_impl_m
