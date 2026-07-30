program ex06_storage_sizes
   use, intrinsic :: iso_fortran_env, only: character_storage_size, numeric_storage_size, file_storage_size, output_unit
   implicit none

   write (output_unit, *) 'Character storage size = ', character_storage_size
   write (output_unit, *) 'Numeric storage size = ', numeric_storage_size
   write (output_unit, *) 'File storage size = ', file_storage_size
end program ex06_storage_sizes