program ex07_abstract_interface_demo
   implicit none

   abstract interface
      real function unary_real_fn(x)
         real, intent(in) :: x
      end function unary_real_fn
   end interface

   real :: xs(5)
   real :: ys(5)
   integer :: i

   xs = [(real(i), i = 1, size(xs))]
   call apply_unary_fn(square, xs, ys)

   write (*, '(*(F10.2))') (ys(i), i = 1, size(ys))
   write (*, *)

contains
   subroutine apply_unary_fn(f, src_arr, dst_arr)
      implicit none

      procedure(unary_real_fn) :: f
      real, dimension(:), intent(in) :: src_arr
      real, dimension(:), intent(out) :: dst_arr
      integer :: idx

      do idx = 1, size(src_arr)
         dst_arr(idx) = f(src_arr(idx))
      end do
   end subroutine apply_unary_fn

   real function square(x)
      implicit none
      real, intent(in) :: x
      square = x * x
   end function square
end program ex07_abstract_interface_demo