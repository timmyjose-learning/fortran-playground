module demo_m
   use, intrinsic :: iso_c_binding, only: c_ptr, c_int, c_float
   implicit none
   private

   interface
      function c_create_engine(id) bind(C, name='create_engine') result(handle)
         import :: c_int, c_ptr
         implicit none

         integer(kind=c_int), intent(in), value :: id
         type(c_ptr) :: handle
      end function c_create_engine

      function c_get_score(handle) bind(C, name='get_score') result(score)
         import :: c_float, c_ptr
         implicit none

         type(c_ptr), intent(in), value :: handle
         real(kind=c_float) :: score
      end function c_get_score

      subroutine c_destroy_engine(handle) bind(C, name='destroy_engine')
         import :: c_ptr
         implicit none

         type(c_ptr), intent(in), value :: handle
      end subroutine c_destroy_engine
   end interface

   public :: c_create_engine, c_get_score, c_destroy_engine
end module demo_m
