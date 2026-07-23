program main
   use math_utils_m, only: calculate, math_result_t
   implicit none

   integer :: x, y
   integer :: iostat
   character(len=512) :: iomsg
   type(math_result_t) :: res

   write (*, *) 'Enter two integers'
   read (*, *, iostat=iostat, iomsg=iomsg) x, y

   if (iostat /= 0) then
      write (*, *) 'Error: ', iomsg
   else
      res = calculate(x, y)
      write (*, '(A,I5,A,I5,A,I5,A,I5)') &
         'Sum = ', res%sum, &
         ', difference = ', res%diff, &
         ', product = ', res%prod, &
         ', and quotient = ', res%quot
   end if
end program main
