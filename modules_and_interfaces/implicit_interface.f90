subroutine print_square(x)
   implicit none

   integer, intent(in) :: x

   write (*, '(A,I5,A,I5)') 'The square of ', x, ' is ', x*x
end subroutine print_square
