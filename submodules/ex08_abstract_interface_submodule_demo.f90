module array_utils_m
   implicit none
   private

   public :: map_array, print_array

   abstract interface
      real function unary_real_fn(x)
         implicit none
         real, intent(in) :: x
      end function unary_real_fn
   end interface

   interface
      module subroutine map_array(f, src_arr, dst_arr)
         implicit none
         procedure(unary_real_fn) :: f
         real, dimension(:), intent(in) :: src_arr
         real, dimension(:), intent(out) :: dst_arr
      end subroutine map_array

      module subroutine print_array(arr)
         implicit none
         real, dimension(:), intent(in) :: arr
      end subroutine print_array
   end interface
end module array_utils_m

submodule(array_utils_m) array_utils_impl_m
   implicit none

contains
   module procedure map_array
      integer :: i

      do i = 1, size(src_arr)
         dst_arr(i) = f(src_arr(i))
      end do
   end procedure map_array

   module procedure print_array
      integer :: i

      write (*, '(*(F10.2))') (arr(i), i = 1, size(arr))
   end procedure print_array
end submodule array_utils_impl_m

program ex08_abstract_interface_submodule_demo
   use array_utils_m, only: map_array, print_array
   implicit none

   real, dimension(5) :: xs, ys
   integer :: i

   xs = [(real(i), i = 1, size(xs))]
   call map_array(square, xs, ys)
   call print_array(ys)

contains
   real function square(x)
      implicit none

      real, intent(in) :: x
      square = x * x
   end function square
end program ex08_abstract_interface_submodule_demo