program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use, intrinsic :: iso_c_binding, only: c_int, c_float, c_ptr, c_associated, c_null_ptr
   use demo_m, only: c_create_engine, c_get_score, c_destroy_engine
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(c_ptr) :: handle
      integer(kind=c_int) :: id
      real(kind=c_float) :: score

      id = 123_c_int
      handle = c_create_engine(id)

      if (.not. c_associated(handle)) then
         error stop 'Received NULL pointer from C'
      end if

      score = c_get_score(handle)
      write (output_unit, '("Score = ",F8.3)') score

      call c_destroy_engine(handle)
      handle = c_null_ptr
   end subroutine run_app
end program main
