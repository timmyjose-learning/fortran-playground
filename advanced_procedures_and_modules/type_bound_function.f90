module point_m
   implicit none
   private

   type :: point_t
      real :: x
      real :: y

   contains
      procedure :: orig_dist => distance_from_origin
   end type point_t

   interface
      module function distance_from_origin(this) result(dist)
         implicit none
         class(point_t), intent(in) :: this
         real :: dist
      end function distance_from_origin
   end interface

   public :: point_t
end module point_m

submodule (point_m) point_impl_m
   implicit none

contains
   module procedure  distance_from_origin
      dist = sqrt(this%x * this%x + this%y * this%y)
   end procedure distance_from_origin
end submodule point_impl_m

program type_bound_function
   use, intrinsic :: iso_fortran_env, only: output_unit, input_unit
   use point_m, only: point_t
   implicit none

   type(point_t) :: pt

   write (output_unit, *) 'Enter the x and y coordinates of the point'
   read (input_unit, *) pt%x, pt%y

   write (output_unit, *) 'Distance from origin = ', pt%orig_dist()
end program type_bound_function