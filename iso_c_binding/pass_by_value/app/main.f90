program main
  use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use, intrinsic :: iso_c_binding, only: c_int
   use demo_m, only: print_x

   call run_app()

contains
   subroutine run_app()
      implicit none

      integer(kind=c_int) :: x

      write (output_unit, *) 'Enter a number'
      read (input_unit, *) x

      call print_x(x)
   end subroutine run_app
end program main
