program main
   use math_utils_m
   implicit none

   integer :: num

   write (*, *) 'Enter an integer'
   read (*, *) num

   write (*, '(A,I5,A,I5,A,I5)') 'The square of ', num, ' is ', square(num), ' and the cube is ', cube(num)
end program main
