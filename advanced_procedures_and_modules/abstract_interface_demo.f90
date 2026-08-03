module maths_m
   implicit none
   private

   abstract interface
      function unary_real_fn(r) result(res)
         implicit none
         real, intent(in) :: r
         real :: res
      end function unary_real_fn
   end interface

   public :: apply_fn, square, cube

contains
   subroutine apply_fn(f, arr)
      implicit none

      procedure(unary_real_fn) :: f
      real, dimension(:), intent(inout) :: arr
      integer :: i

      do i = 1, size(arr)
         arr(i) = f(arr(i))
      end do
   end subroutine apply_fn

   function square(r) result(res)
      implicit none

      real, intent(in) :: r
      real :: res

      res = r * r
   end function square

   function cube(r) result(res)
      implicit none

      real, intent(in) :: r
      real :: res

      res = r * r * r
   end function cube
end module maths_m

program abstract_interface_demo
   use maths_m, only: apply_fn, square, cube
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      real, dimension(5) :: arr = [1.0, 2.0, 3.0, 4.0, 5.0]

      call apply_fn(square, arr)
      write (*, *) arr

      call apply_fn(cube, arr)
      write (*, *) arr
   end subroutine run_app
end program abstract_interface_demo