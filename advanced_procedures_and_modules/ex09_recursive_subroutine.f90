program ex09_recursive_subroutine
   implicit none

   integer :: num
   integer :: res

   write (*, *) 'Enter a number'
   read (*, *) num

   call factorial(num, res)
   write (*, *) res

contains
   recursive subroutine factorial(n, fact)
      implicit none

      integer, intent(in) :: n
      integer, intent(inout) :: fact
      integer :: temp

      if (n <= 1) then
         fact = 1
      else
         call factorial(n - 1, temp)
         fact = n * temp
      end if
   end subroutine factorial
end program ex09_recursive_subroutine