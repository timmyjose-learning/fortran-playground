module counter_m
   implicit none
   private

   type :: counter_t
      integer :: counter = 0

   contains
      procedure :: increment => increment_counter
      procedure :: value => show_counter_value
   end type counter_t

   public :: counter_t

contains
   subroutine increment_counter(this)
      implicit none

      class(counter_t), intent(inout) :: this

      this%counter = this%counter + 1
   end subroutine increment_counter

   function show_counter_value(this) result(val)
      implicit none

      class(counter_t), intent(in) :: this
      integer :: val

      val = this%counter
   end function show_counter_value
end module counter_m

program mutating_bound_procedure
   use, intrinsic :: iso_fortran_env, only: output_unit
   use counter_m, only: counter_t
   implicit none

   type(counter_t) :: counter
   integer :: i

   write (output_unit, *) 'Initial value of counter = ', counter%value()

   do i = 1, 10
      call counter%increment()
   end do

   write (output_unit, *) 'After 10 increments, counter = ', counter%value()
end program mutating_bound_procedure