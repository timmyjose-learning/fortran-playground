program ex11_reshape
   implicit none

   integer :: i, j
   integer :: a(2, 3)

   ! Fortran is column major, so the nested expression uses `i`
   a = reshape([((i*j, i=1, size(a, 1)), j=1, size(a, 2))], shape(a))

   do i = 1, size(a, 1)
      write (*, '(*(I6))') a(i, :)
   end do

   do i = 1, size(a, 1)
      write (*, '(*(I6))') (a(i, j), j=1, size(a, 2))
   end do
end program ex11_reshape
