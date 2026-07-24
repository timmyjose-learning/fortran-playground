program main
   use builtin_functions_m, only: square, cube, negate
   use function_runner_m, only: print_table, map_array
   implicit none

   integer, parameter :: ARR_SIZE = 5
   real, dimension(ARR_SIZE) :: xs, ys
   integer:: i

   xs = [(real(i), i=-ARR_SIZE/2, ARR_SIZE/2)]

   call print_table(square, xs)
   call print_table(cube, xs)
   call print_table(negate, xs)

   call map_array(square, xs, ys)
   write (*, '(*(F8.3))') ys
end program main
