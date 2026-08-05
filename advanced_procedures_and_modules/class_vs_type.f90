! type(foo) means the exact type, `foo`
! class(foo) means `foo`, or an extension of `foo`

module oops_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: base_t
      integer :: id

   contains
      procedure :: print => print_base
   end type base_t

   type, extends(base_t) :: child_t
      integer :: extra

   contains
      procedure :: print => print_child
   end type child_t

   public :: base_t, child_t

contains
   subroutine print_base(this)
      implicit none

      class(base_t), intent(in) :: this

      write (output_unit, '("<base id = ",I0,">")') this%id
   end subroutine print_base

   subroutine print_child(this)
      implicit none

      class(child_t), intent(in) :: this

      write (output_unit, '("<child id = ",I0, ", extra = ",I0,">")') this%id, this%extra
   end subroutine print_child
end module oops_m

program class_vs_type
   use oops_m, only: base_t, child_t
   implicit none

   type(base_t) :: base
   type(child_t) :: child

   base%id = 1
   call base%print()

   child%id = 2
   child%extra = 999
   call child%print()
end program class_vs_type