program ex01_io_units
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit, error_unit
   implicit none

   integer :: x

   write (output_unit, *) 'Enter a number'
   read (input_unit, *) x

   write (output_unit, *) 'You entered: ', x
   write (error_unit, *) 'This is written to stderr'
end program ex01_io_units