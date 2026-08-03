subroutine double_elements(arr)
   implicit none

   real, dimension(:), intent(inout) :: arr
   integer :: i

   do i = 1, size(arr)
      arr(i) = 2.0 * arr(i)
   end do
end subroutine double_elements

program the_implicit_interface_trap
   implicit none

   real, dimension(5) :: arr = [1.0, 2.0, 3.0, 4.0, 5.0]
   ! compilation error since, for assumed-shaped arrays, an explicit interface is needed
   call double_elements(arr)
   write (*, *) arr
end program the_implicit_interface_trap