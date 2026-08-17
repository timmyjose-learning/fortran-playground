program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use, intrinsic :: iso_c_binding, only: c_int, c_funloc
   use demo_m, only: c_apply, add, sub

   call run_app()

contains
   subroutine run_app()
      implicit none

      integer(kind=c_int) :: res

      res = c_apply(1_c_int, 2_c_int, c_funloc(add))
      write (output_unit, *) res

      res = c_apply(1_c_int, 2_c_int, c_funloc(sub))
      write (output_unit, *) res
   end subroutine run_app
end program main
