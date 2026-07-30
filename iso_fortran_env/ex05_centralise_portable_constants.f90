module constants_m
   use, intrinsic :: iso_fortran_env, only: int32, real64
   private

   integer, parameter :: INT_K = int32
   ! remember that kinds are always integer constants
   integer, parameter :: REAL_K = real64

   public :: INT_K, REAL_K
end module constants_m

program ex05_centralise_portable_constants
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use constants_m, only: INT_K, REAL_K
   implicit none

   integer(kind=INT_K) :: x
   real(kind=REAL_K) :: r

   write (output_unit, *) 'Enter an integer and a real number'
   read (input_unit, *) x, r

   write (output_unit, *) 'You entered ', x, ', and ', r
end program ex05_centralise_portable_constants