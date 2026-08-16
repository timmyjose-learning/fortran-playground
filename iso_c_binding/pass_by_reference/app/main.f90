program main
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use, intrinsic :: iso_c_binding, only: c_int
   use demo_m, only: add_five
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      integer(kind=c_int) :: x

      write (output_unit, *) 'Enter a number'
      read (input_unit, *) x

      write (output_unit, *) 'Before, x = ', x
      call add_five(x)
      write (output_unit, *) 'After, x = ', x
      end subroutine run_app
   end program main
