program move_alloc_demo
   implicit none

   call run_app()

contains
   subroutine run_app()
      integer, dimension(:), allocatable :: array
      integer, dimension(:), allocatable :: temp

      allocate(array(3))

      array = [1, 2, 3]

      allocate(temp(5))
      temp(1:3) = array

      temp(4) = 4
      temp(5) = 5

      call move_alloc(from=temp, to=array)
      write (*, '(*(I5))') array
   end subroutine run_app
end program move_alloc_demo
