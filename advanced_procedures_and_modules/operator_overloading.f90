module vector_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: vec2_t
      real :: x
      real :: y
   end type vec2_t

   interface operator(+)
      module procedure add_vec2
   end interface

   public :: vec2_t, print_vec2, operator(+)

contains
   function add_vec2(vec1, vec2) result(sum)
      implicit none

      type(vec2_t), intent(in) :: vec1, vec2
      type(vec2_t) :: sum

      sum%x = vec1%x + vec2%x
      sum%y = vec1%y + vec2%y
   end function add_vec2

   subroutine print_vec2(vec)
      implicit none

      type(vec2_t), intent(in) :: vec

      write (output_unit, '("(",F8.2,", ",F8.3,")")') vec%x, vec%y
   end subroutine print_vec2
end module vector_m

program operator_overloading
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use vector_m, only: vec2_t, print_vec2, operator(+)
   implicit none

   type(vec2_t) :: vec1, vec2, vec3

   write (output_unit, *) 'Enter the first vector'
   read (input_unit, *) vec1%x, vec1%y

   write (output_unit, *) 'Enter the second vector'
   read (input_unit, *) vec2%x, vec2%y

   vec3 = vec1 + vec2

   call print_vec2(vec3)
end program operator_overloading