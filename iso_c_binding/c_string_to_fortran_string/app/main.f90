program main
   use, intrinsic :: iso_fortran_env, only: output_unit, error_unit
   use, intrinsic :: iso_c_binding, only: c_ptr, c_char, c_f_pointer, c_null_ptr, c_size_t
   use demo_m, only: c_get_c_string
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(c_ptr) :: cptr
      integer(kind=c_size_t) :: length
      character(kind=c_char), dimension(:), pointer :: fptr
      character(len=:), allocatable :: str
      integer :: stat
      character(len=512) :: errmsg

      nullify(fptr)

      cptr = c_get_c_string(length)
      call c_f_pointer(cptr, fptr, [int(length) + 1]) ! +1 for the `NUL` character

      if (length /= 0) then
         allocate(character(len=length) :: str, stat=stat, errmsg=errmsg)
         call check_mem(stat, errmsg)

         block
            integer :: i

            do i = 1, length
               str(i:i) = fptr(i)
            end do
         end block
         write (output_unit, *) str
      end if

      ! clean-up
      nullify(fptr)
      cptr = c_null_ptr
   end subroutine run_app

   subroutine check_mem(stat, errmsg)
      implicit none

      integer, intent(in) :: stat
      character(len=*), intent(in) :: errmsg

      if (stat /= 0) then
         write (error_unit, *) 'Error during allocation: ' // errmsg
         error stop
      end if
   end subroutine check_mem
end program main
