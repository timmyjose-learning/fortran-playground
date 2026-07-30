program ex04_portable_real_kinds
   use, intrinsic :: iso_fortran_env, only: real32, real64, real128, output_unit
   implicit none

   real(kind=real32) :: x32
   real(kind=real64) :: x64
   real(kind=real128) :: x128

   x32 = 1.0_real32 / 3.0_real32
   x64 = 1.0_real64 / 3.0_real64
   x128 = 1.0_real128 / 3.0_real128

   write (output_unit, *) 'x32 = ', x32
   write (output_unit, *) 'x64 = ', x64
   write (output_unit, *) 'x128 = ', x128

   write (output_unit, *) 'Precision of real32 = ', precision(x32)
   write (output_unit, *) 'Precision of real64 = ', precision(x64)
   write (output_unit, *) 'Precision of real128 = ', precision(x128)
end program ex04_portable_real_kinds