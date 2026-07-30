program ex07_compiler_info
   use, intrinsic :: iso_fortran_env, only: compiler_version, compiler_options, output_unit
   implicit none

   write (output_unit, *) 'Compiler version = ', compiler_version()
   write (output_unit, *) 'Compiler options = ', compiler_options()
end program ex07_compiler_info