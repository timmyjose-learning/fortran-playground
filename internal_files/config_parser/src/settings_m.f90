module settings_m
   implicit none
   private

   type :: settings_t
      integer :: width
      integer :: height
      real :: scale
      logical :: debug
      character(len=:), allocatable :: title
   end type settings_t

   public :: settings_t
end module settings_m
