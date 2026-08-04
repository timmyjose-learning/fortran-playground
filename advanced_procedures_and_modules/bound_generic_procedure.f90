module box_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: box_t
      private
      integer :: value = 0

   contains
      procedure, pass(this) :: set_from_int, set_from_real
      procedure, pass(this) :: print => print_box
      generic :: set => set_from_int, set_from_real
   end type box_t

   public :: box_t

contains
   subroutine set_from_int(this, d)
      implicit none

      class(box_t), intent(inout) :: this
      integer, intent(in) :: d

      this%value = d
   end subroutine set_from_int

   subroutine set_from_real(this, r)
      implicit none

      class(box_t), intent(inout) :: this
      real, intent(in) :: r

      this%value = nint(r)
   end subroutine set_from_real

   subroutine print_box(this)
      implicit none

      class(box_t), intent(in) :: this

      write (output_unit, '("{ value = ",I0," }")') this%value
   end subroutine print_box
end module box_m

program bound_generic_procedure
   use box_m, only: box_t
   implicit none

   type(box_t) :: box

   call box%set(12345)
   call box%print()

   call box%set(2.78128)
   call box%print()
end program bound_generic_procedure