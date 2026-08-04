module scaler_m
   implicit none
   private

   type :: scaler_t
      real :: factor = 1.0

   contains
      procedure, pass(this) :: apply => apply_scale_factor
   end type scaler_t

   public :: scaler_t

contains
   function apply_scale_factor(this, r) result(scaled)
      implicit none

      class(scaler_t), intent(in) :: this
      real, intent(in) :: r
      real :: scaled

      scaled = this%factor * r
   end function apply_scale_factor
end module scaler_m

program explicit_pass
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   use scaler_m, only: scaler_t
   implicit none

   type(scaler_t) :: scaler
   real :: r

   write (output_unit, *) 'Enetr the number'
   read (input_unit, *) r

   scaler%factor = 10

   write (output_unit, *) r, ' scaled by a factor of 10 is ', scaler%apply(r)
end program explicit_pass