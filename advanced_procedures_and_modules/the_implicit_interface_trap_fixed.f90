subroutine double_elements(arr)
   implicit none

   real, dimension(:), intent(inout) :: arr
   integer :: i

   do i = 1, size(arr)
      arr(i) = 2.0 * arr(i)
   end do
end subroutine double_elements

program the_implicit_interface_trap_fixed
   implicit none

   ! providing an explicit interface fixes the issue
   interface
      subroutine double_elements(a)
         implicit none

         real, dimension(:), intent(inout) :: a
      end subroutine double_elements
   end interface

   real, dimension(5) :: arr = [1.0, 2.0, 3.0, 4.0, 5.0]

   call double_elements(arr)
   write (*,*) arr
end program the_implicit_interface_trap_fixed