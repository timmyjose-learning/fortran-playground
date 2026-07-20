program ex04_declaration_init
   implicit none

   integer :: i
   integer, dimension(5) :: nums = [(i, i=1, 5)]
   integer, dimension(5) :: squares = [(i**2, i=1, 5)]

   write (*, *) nums
   write (*, *) squares
end program ex04_declaration_init
