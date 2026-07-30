program ex09_check_availability
   use, intrinsic :: iso_fortran_env, only: real128, output_unit, error_unit
   implicit none

   if (real128 > 0)  then! negative or -1 indicates non-availability
      write (output_unit, *) 'rel128 is available'
   else
      write (error_unit, *) 'real128 is not available'
   end if
end program ex09_check_availability