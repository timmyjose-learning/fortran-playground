module vector_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: vec3_t
      real :: x
      real :: y
      real :: z
   end type vec3_t

   interface operator (.cross.)
      module procedure cross_prod_vec3
   end interface

   public :: vec3_t, make_vec3, print_vec3, operator(.cross.)

contains
   function cross_prod_vec3(vec1, vec2) result (prod)
      implicit none

      type(vec3_t), intent(in) :: vec1, vec2
      type(vec3_t) :: prod

      prod%x = vec1%y * vec2%z + vec1%z * vec2%y
      prod%y = vec1%x * vec2%x + vec1%z * vec2%x
      prod%z = vec1%x * vec2%y + vec1%z * vec2%y
   end function cross_prod_vec3

   function make_vec3(x, y, z) result(vec)
      implicit none

      real, intent(in) :: x, y, z
      type(vec3_t) :: vec

      vec%x = x
      vec%y = y
      vec%z = z
   end function make_vec3

   subroutine print_vec3(vec)
      implicit none

      type(vec3_t), intent(in) :: vec

      write (output_unit, '("(",F8.3,",",F8.3,",",F8.3,")")') vec%x, vec%y, vec%z
   end subroutine print_vec3
end module vector_m

program user_defined_operator
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use vector_m, only: vec3_t, make_vec3, print_vec3, operator(.cross.)
   implicit none

   type(vec3_t) :: v1, v2, v3

   write (output_unit, *) 'Enter the first vector'
   read (input_unit, *) v1%x, v1%y, v1%z

   write (output_unit, *) 'Enter the second vector'
   read (input_unit, *) v2%x, v2%y, v2%z

   v3 = v1 .cross. v2
   call print_vec3(v3)
end program user_defined_operator