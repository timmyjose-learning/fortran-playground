program ex03_step
   implicit none

   integer :: i
   integer, dimension(5) :: evens, odds

   evens = [(i, i=2, 10, 2)]
   odds = [(i, i=1, 10, 2)]

   write (*, *) 'Evens = ', evens
   write (*, *) 'Odds = ', odds
end program ex03_step
