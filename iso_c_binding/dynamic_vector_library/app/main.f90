program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use, intrinsic :: iso_c_binding, only: c_double
   use demo_m, only: vector_handle_t
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(vector_handle_t) :: vec
      real(kind=c_double), dimension(:), pointer :: arr
      integer :: i

      call vec%init()
      do i = 1, 10
         call vec%push(real(i, kind=c_double))
      end do

      arr => vec%get_array()
      if (associated(arr)) then
         write (output_unit, '(*(F8.3,", ",:,1X))') (arr(i), i = 1, size(arr))
      end if

      call vec%free()

      nullify(arr)
   end subroutine run_app
end program main
