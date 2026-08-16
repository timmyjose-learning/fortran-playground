program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use, intrinsic :: iso_c_binding, only: c_double
   use demo_m, only: point_t, c_dist_from_origin
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(point_t) :: pt

      pt%x = 3.0_c_double
      pt%y = 4.0_c_double

      write (output_unit, '("Distance from origin = ",F8.3)') c_dist_from_origin(pt)
   end subroutine run_app
end program main
