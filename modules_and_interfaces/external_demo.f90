program external_demo
   implicit none

   real :: num
   real:: result

   write (*, *) 'Enter a number'
   read (*, *) num

   call apply(square, num, result)
   write (*, *) 'Result = ', result

contains
   subroutine apply(f, x, res)
      implicit none

      real, external :: f
      real, intent(in) :: x
      real, intent(out) :: res

      res = f(x)
   end subroutine apply

   real function square(x)
      implicit none

      real, intent(in) :: x
      square = x**2
   end function square
end program external_demo
