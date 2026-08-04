module vector_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: vec2_t
      real :: x
      real :: y
   end type vec2_t

   interface operator(*)
      module procedure scalar_times_vec2
      module procedure vec2_times_scalar
   end interface

   public :: vec2_t, make_vec2, print_vec2, operator(*)

contains
   function make_vec2(x, y) result(vec)
      implicit none

      real, intent(in) :: x, y
      type(vec2_t) :: vec

      vec%x = x
      vec%y = y
   end function make_vec2

   function scalar_times_vec2(s, vec) result(prod)
      implicit none

      real, intent(in) :: s
      type(vec2_t), intent(in) :: vec
      type(vec2_t) :: prod

      prod%x = s * vec%x
      prod%y = s * vec%y
   end function scalar_times_vec2

   function vec2_times_scalar(vec, s) result(prod)
      implicit none

      type(vec2_t), intent(in) :: vec
      real, intent(in) :: s
      type(vec2_t) :: prod

      prod%x = vec%x * s
      prod%y = vec%y * s
   end function vec2_times_scalar

   subroutine print_vec2(vec)
      implicit none

      type(vec2_t), intent(in) :: vec

      write (output_unit, '("(",F8.3,", ",F8.3,")")') vec%x, vec%y
   end subroutine print_vec2
end module vector_m

program mixed_mode_operator_overload
   use, intrinsic :: iso_fortran_env, only: output_unit, input_unit
   use vector_m, only: vec2_t,  make_vec2, print_vec2, operator(*)
   implicit none

   type(vec2_t) :: vec1, vec2, vec3
   real :: x, y
   real :: r

   write (output_unit, *) 'Enter the first vector'
   read (input_unit, *) x, y

   vec1 = make_vec2(x, y)

   write (output_unit, *) 'Enter the scalar'
   read (input_unit, *) r

   vec2 = r * vec1
   vec3 = vec1 * r

   call print_vec2(vec2)
   call print_vec2(vec3)
end program mixed_mode_operator_overload