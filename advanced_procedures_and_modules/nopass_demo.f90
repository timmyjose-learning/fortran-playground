module widget_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: widget_t
      integer :: id

   contains
      procedure, pass(this) :: print => print_widget
      procedure, nopass :: describe_widget
   end type widget_t

   public :: widget_t

contains
   subroutine print_widget(this)
      implicit none

      class(widget_t), intent(in) :: this

      write (output_unit, '("<widget id = ",I0,"</widget>")') this%id
   end subroutine print_widget

   subroutine describe_widget()
      implicit none

      write (output_unit,*) 'A simple widget with an id'
   end subroutine describe_widget
end module widget_m

program nopass_demo
   use widget_m, only: widget_t
   implicit none

   type(widget_t) :: widget

   widget%id = 12345
   call widget%print()
   call widget%describe_widget()
end program nopass_demo