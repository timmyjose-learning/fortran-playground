module counter_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: counter_t
      private
      integer :: value = 0

   contains
      procedure :: increment
      procedure :: get
      procedure :: print
   end type counter_t

   public :: counter_t, make_counter

contains
   pure function make_counter() result(counter)
      implicit none

      type(counter_t) :: counter

      counter%value = 0
   end function make_counter

   subroutine increment(this)
      implicit none

      class(counter_t), intent(inout) :: this

      this%value = this%value + 1
   end subroutine increment

   subroutine print(this)
      implicit none

      class(counter_t), intent(in) :: this

      write (output_unit, *) 'counter = ', this%value
   end subroutine print

   pure function get(this) result(counter_val)
      implicit none

      class(counter_t), intent(in) :: this
      integer :: counter_val

      counter_val = this%value
   end function get
end module counter_m


program counter_demo
   use, intrinsic :: iso_fortran_env, only: output_unit
   use counter_m, only: make_counter, counter_t
   implicit none

   type(counter_t) :: ctr

   ctr = make_counter()
   call ctr%print()
   call ctr%increment
   write (output_unit, *) ctr%get()
end program counter_demo
