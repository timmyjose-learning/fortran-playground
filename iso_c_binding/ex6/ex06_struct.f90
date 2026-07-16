program ex06_struct
   use, intrinsic :: iso_c_binding, only: c_double
   implicit none

   type, bind(C) :: point_t
      real(kind=c_double) :: x
      real(kind=c_double) :: y
   end type point_t

   interface
      function c_line_length(p1, p2) bind(C, name='c_line_length') result(res)
         import :: c_double, point_t
         implicit none

         type(point_t), intent(in) :: p1, p2
         real(kind=c_double) :: res
      end function c_line_length
   end interface

   type(point_t) :: p1, p2
   real(kind=c_double) :: dist

   p1%x = 1.0
   p1%y = 2.0

   p2%x = 3.0
   p2%y = 5.0

   dist = c_line_length(p1, p2)
   write (*, *) 'Distance from ', p1, ' to ', p2, ' is ', dist
end program ex06_struct
