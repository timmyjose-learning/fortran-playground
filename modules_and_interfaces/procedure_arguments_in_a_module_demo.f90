module array_utils_m
   implicit none
   private

   abstract interface
      real function unary_fn(r)
         implicit none

         real, intent(in) :: r
      end function unary_fn
   end interface

   public :: square, apply_to_array

contains
   subroutine apply_to_array(f, in_arr, out_arr)
      implicit none

      procedure(unary_fn) :: f
      real, dimension(:), intent(in) :: in_arr
      real, dimension(:), intent(out) :: out_arr
      integer :: i

      if (size(in_arr) /= size(out_arr)) then
         error stop 'Mismatched array sizes'
      end if

      do i = 1, size(in_arr)
         out_arr(i) = f(in_arr(i))
      end do
   end subroutine apply_to_array

   real function square(x) result(res)
      implicit none

      real, intent(in) :: x
      res = x**2
   end function square
end module array_utils_m

program procedure_arguments_in_a_module_demo
   use array_utils_m, only: apply_to_array, square
   implicit none

   integer, parameter :: ARR_SIZE = 5
   real, dimension(ARR_SIZE) :: xs, ys
   integer :: i

   xs = [(real(i), i=1, ARR_SIZE)]
   call apply_to_array(square, xs, ys)

   write (*, *) ys
end program procedure_arguments_in_a_module_demo

