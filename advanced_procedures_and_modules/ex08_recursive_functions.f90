program ex08_recursive_functions
   implicit none

   integer :: num

   write (*, *) 'Enter a number'
   read (*, *) num
   write (*, *) factorial(num)

contains
   recursive function factorial(n) result(fact)
      implicit none

      integer, intent(in) :: n
      integer :: fact

      if (n <= 1) then
         fact = 1
      else
         fact = n * factorial(n - 1)
      end if
   end function factorial
end program ex08_recursive_functions