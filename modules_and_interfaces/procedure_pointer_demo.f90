program procedure_pointer_demo
   implicit none

   abstract interface
      real function unary_real_fn(r)
         implicit none

         real, intent(in) :: r
      end function unary_real_fn
   end interface

   real :: num
   procedure(unary_real_fn), pointer :: fptr => null()

   ! This works without a `target` attribute since function names are references/pointers
   fptr => square
   write (*, *) 'Enter a number'
   read (*, *) num

   write (*, '(A,F8.3,A,F8.3)') 'Square of ', num, ' is ', fptr(num)
   fptr => double
   write (*, '(A,F8.3,A,F8.3)') 'Double of ', num, ' is ', fptr(num)

contains
   real function square(x)
      implicit none

      real, intent(in) :: x
      square = x*x
   end function square

   real function double(x)
      implicit none

      real, intent(in) :: x
      double = 2.0*x
   end function double
end program procedure_pointer_demo
