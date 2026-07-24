program abstract_interface_demo
   implicit none

   abstract interface
      real function unary_fn(x)
         implicit none

         real, intent(in) :: x
      end function unary_fn
   end interface

   real :: num
   real :: result

   write (*, *) 'Enter a number'
   read (*, *) num

   call apply(square, num, result)
   write (*, *) result

contains
   subroutine apply(f, x, res)
      implicit none

      procedure(unary_fn) :: f
      real, intent(in) :: x
      real, intent(out) :: res

      res = f(x)
   end subroutine apply

   real function square(x) result(res)
      implicit none

      real, intent(in) :: x
      res = x**2
   end function square
end program abstract_interface_demo
