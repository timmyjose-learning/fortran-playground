module noisy_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: noisy_t
      character(len=:), allocatable :: name
   contains
      final :: finalize_noisy
   end type noisy_t

   public :: noisy_t

contains
   subroutine finalize_noisy(this)
      implicit none

      type(noisy_t), intent(inout) :: this

      if (allocated(this%name)) then
         write (output_unit, '("Finalizing ",A)') this%name
      else
         write (output_unit, '("Finalizing unnamed object")')
      end if
   end subroutine finalize_noisy
end module noisy_m

program finalizer_demo
   use noisy_m, only: noisy_t
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(noisy_t) :: noisy

      block
         noisy%name = 'Bob'
      end block
   end subroutine run_app
end program finalizer_demo