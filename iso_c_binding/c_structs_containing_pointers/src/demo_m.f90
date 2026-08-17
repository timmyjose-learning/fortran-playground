module demo_m
   use, intrinsic :: iso_c_binding, only: c_int, c_ptr
   implicit none
   private

   type, bind(C) :: c_vector_t
      integer(kind=c_int) :: size
      type(c_ptr) :: data ! This is c_ptr, not `real(kind=c_double), pointer`
   end type c_vector_t

   interface
      subroutine c_fill_data(vec) bind(C, name='fill_data')
         import :: c_vector_t

         type(c_vector_t), intent(inout) :: vec
      end subroutine c_fill_data
   end interface

   public :: c_vector_t, c_fill_data
end module demo_m
