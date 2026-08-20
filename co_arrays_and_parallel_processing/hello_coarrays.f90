program hello_coarrays
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      write (output_unit, '("Hello from image: ",I0,", out of ",I0," images")') this_image(), num_images()
   end subroutine run_app
end program hello_coarrays