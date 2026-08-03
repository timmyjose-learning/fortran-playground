program ex13_env_var
   use, intrinsic :: iso_fortran_env, only: output_unit, error_unit
   implicit none

   integer :: status
   character(len=256) :: value

   call get_environment_variable("OYI_MODE", value, status=status)

   if (status /= 0) then
      write (error_unit, *) 'OYI_MODE not set'
   else
      write (output_unit, *) 'OYI_MODE set, and its value is: ', value
   end if
end program ex13_env_var