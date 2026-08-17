program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use, intrinsic :: iso_c_binding, only: c_int, c_double, c_f_pointer, c_loc, c_null_ptr
   use demo_m, only: c_vector_t, c_fill_data
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(c_vector_t) :: vec
      real(kind=c_double), dimension(:), allocatable, target :: buffer
      real(kind=c_double), dimension(:), pointer :: fptr
      integer :: stat
      character(len=512) :: errmsg

      vec%size = 5_c_int
      allocate(buffer(vec%size), stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)

      vec%data = c_loc(buffer(1)) ! address of the first cell in the buffer
      call c_fill_data(vec)
      call c_f_pointer(vec%data, fptr, [vec%size])

      block
         integer :: i
         write (output_unit, *) (fptr(i), i = 1, size(fptr))
      end block

      nullify(fptr)
      vec%data = c_null_ptr
   end subroutine run_app

   subroutine check_mem(stat, errmsg)
      implicit none

      integer, intent(in) :: stat
      character(len=*), intent(in) :: errmsg

      if (stat /= 0) then
         error stop 'Error during allocation/deallocation: ' // errmsg
      end if
   end subroutine check_mem
end program main
