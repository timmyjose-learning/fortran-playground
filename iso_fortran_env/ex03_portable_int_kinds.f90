program ex03_portable_int_kinds
   use, intrinsic :: iso_fortran_env, only: int8, int16, int32, int64, output_unit
   implicit none

   integer(kind=int8) :: i8
   integer(kind=int16) :: i16
   integer(kind=int32) :: i32
   integer(kind=int64) :: i64

   write (output_unit, *) 'Max value of i8 = ', huge(i8)
   write (output_unit, *) 'Max value of i16 = ', huge(i16)
   write (output_unit, *) 'Max value of i32 = ', huge(i32)
   write (output_unit, *) 'Max value of i64 = ', huge(i64)
end program ex03_portable_int_kinds