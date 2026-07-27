program ex09_procedure_pointer
   implicit none

   abstract interface
      real function unary_real_fn(x)
         implicit none
         real, intent(in) :: x
      end function unary_real_fn
   end interface

   procedure(unary_real_fn), pointer :: fptr => null()

   fptr => square
   write (*, *) fptr(10.0)

   fptr => double_it
   write (*, *) fptr(10.0)

contains
   real function square(n)
      implicit none
      real, intent(in) :: n
      square = n * n
   end function square

   real function double_it(n)
      implicit none
      real, intent(in) :: n
      double_it = 2.0 * n
   end function double_it
end program ex09_procedure_pointer