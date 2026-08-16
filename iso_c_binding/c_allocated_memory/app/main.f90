program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use, intrinsic :: iso_c_binding, only: c_int, c_ptr, c_f_pointer, c_null_ptr
   use demo_m, only: c_allocate_ints, c_free_allocated_ints
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(c_ptr) :: ptr
      integer(kind=c_int), dimension(:), pointer :: fptr => null()

      ptr = c_allocate_ints(5_c_int)
      call c_f_pointer(ptr, fptr, [5])
      call print_array(fptr)

      ! don't forget to free the memory
      nullify(fptr)
      call c_free_allocated_ints(ptr)
      ptr = c_null_ptr
   end subroutine run_app

   subroutine print_array(arr)
      implicit none

      integer(kind=c_int), dimension(:), intent(in) :: arr
      integer :: i

      write (output_unit, '(*(I0,:,1X))') (arr(i), i = 1, size(arr))
   end subroutine print_array
end program main
