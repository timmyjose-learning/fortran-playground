program assumed_shape_demo
   implicit none

   ! always use an explicit interface when using
   ! assumed-shape arrays
   interface
      subroutine assumed_shape(arr)
         implicit none

         integer, intent(in) :: arr(:)
      end subroutine assumed_shape
   end interface

   integer :: a(5) = [1, 2, 3, 4, 5]

   call assumed_shape(a)
end program assumed_shape_demo
