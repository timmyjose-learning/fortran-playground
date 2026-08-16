module demo_m
   use, intrinsic :: iso_c_binding, only: c_double
   implicit none
   private

   type, bind(C) :: point_t
      real(kind=c_double) :: x
      real(kind=c_double) :: y
   end type point_t

   interface
      function c_dist_from_origin(point) bind(C, name='dist_from_origin') result(dist)
         import :: c_double, point_t
         implicit none

         type(point_t), value :: point
         real(kind=c_double) :: dist
      end function c_dist_from_origin
   end interface

   public :: point_t, c_dist_from_origin
end module demo_m



