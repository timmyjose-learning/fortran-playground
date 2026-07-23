program main
   use math_utils_m, only: cube
   implicit none

   integer :: num

   write (*, *) 'Enter an integer'
   read (*, *) num

   write (*, *) cube(num)
   ! This is an error since `square` was not brought into scope
   !write (*, *) square(num)
end program main
