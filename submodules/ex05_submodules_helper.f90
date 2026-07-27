module helper_m
   implicit none
   private

   public :: fill_squares

   interface
      module subroutine fill_squares(arr)
         implicit none
         integer, dimension(:), intent(out) :: arr
      end subroutine fill_squares
   end interface
end module helper_m

submodule(helper_m) helper_impl_m
   implicit none

contains
   module procedure fill_squares
      integer :: i

      do i= 1, size(arr)
         arr(i) = square(i)
      end do

   contains
      pure integer function square(x)
         implicit none

         integer, intent(in) :: x
         square = x ** 2
      end function square
   end procedure fill_squares
end submodule helper_impl_m

program ex05_submodules_helper
   use helper_m, only: fill_squares
   implicit none

   integer :: arr(5) = 0
   integer :: i

   call fill_squares(arr)
   write (*, '(*(I5))') (arr(i), i = 1, size(arr))
end program ex05_submodules_helper