program local_state
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      integer :: x ! local variable

      x = 1

      write (output_unit, '("x in image ",I0," is ",I0)') this_image(), x
   end subroutine run_app
end program local_state
