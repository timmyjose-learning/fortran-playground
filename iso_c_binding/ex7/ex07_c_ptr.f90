program ex07_c_ptr
   use, intrinsic :: iso_c_binding, only: c_int, c_double, c_ptr, c_f_pointer
   implicit none

   interface
      function c_make_array(n) bind(C, name='c_make_array') result(ptr)
         import :: c_int, c_ptr
         integer(kind=c_int), value :: n
         type(c_ptr) :: ptr
      end function c_make_array

      subroutine c_free_array(p) bind(C, name='c_free_array')
         import :: c_ptr

         type(c_ptr), value :: p
      end subroutine c_free_array
   end interface

   integer(c_int) :: n
   type(c_ptr) :: raw
   real(c_double), pointer :: arr(:)

   n = 5_c_int
   raw = c_make_array(n)

end program ex07_c_ptr
