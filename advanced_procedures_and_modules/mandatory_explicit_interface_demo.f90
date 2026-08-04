subroutine print_array(arr)
   implicit none

   integer, dimension(:), intent(in) :: arr
   integer :: i

   write (*, '(*(I5))') (arr(i), i = 1, size(arr))
end subroutine print_array

program mandatory_explicit_interface_demo
   implicit none

   ! without this explicit interface block, this program would not compile
   ! since we're using an assumed-shape argument (array)
   interface
      subroutine print_array(a)
         implicit none
         integer, dimension(:), intent(in) :: a
      end subroutine print_array
   end interface

   integer, dimension(7) :: arr = [1, 2, 3, 4, 5, 6, 7]

   call print_array(arr)
end program mandatory_explicit_interface_demo