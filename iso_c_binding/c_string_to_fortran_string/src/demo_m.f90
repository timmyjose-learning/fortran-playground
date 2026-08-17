module demo_m
   use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
   implicit none
   private

   interface
      function c_get_c_string(length) bind(C, name='get_c_string') result(res)
         import :: c_ptr, c_size_t
         implicit none

         integer(kind=c_size_t), intent(out) :: length ! pointer, not value
         type(c_ptr) :: res
      end function c_get_c_string
   end interface

   public :: c_get_c_string
end module demo_m
