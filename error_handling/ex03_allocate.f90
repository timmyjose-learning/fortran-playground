program ex03_allocate
   implicit none

   real, allocatable :: xs(:)
   integer :: stat
   character(len=256) :: errmsg

   allocate (xs(1000000), stat=stat, errmsg=errmsg)

   if (stat /= 0) then
      write (*, *) 'Error while allocating array: ', trim(errmsg)
   end if

   xs = 1.0
   write (*, *) 'Sum = ', sum(xs)
end program ex03_allocate
