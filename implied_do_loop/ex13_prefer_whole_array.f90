program ex13_prefer_whole_array
   implicit none

   integer :: i
   integer, dimension(5) :: a, b

   a = [(0, i=1, 5)]

   ! same as, and better in many ways than the above
   b = 0

   write (*, '(*(I6))') a
   ! also the same as (barring formatting), and better
   write (*, *) b
end program ex13_prefer_whole_array
