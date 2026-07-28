program ex14_internal_read_after_external_read
   implicit none

   character(len=64) :: inputs(3)
   character(len=64) :: line
   integer :: i
   integer :: id
   real:: val
   integer :: iostat

   inputs(1) = '12 -2.348'
   inputs(2) = 'bad input'
   inputs(3) = '99  2.28128'

   do i = 1, size(inputs)
      ! simulate reading from a file etc.
      line = inputs(i)
      read (line,*, iostat=iostat) id, val

      if (iostat /= 0) then
         write (*, *) 'Failed to parse: ', trim(line)
      else
         write (*, '("id: ",I5, ", value: ",F10.3)') id, val
      end if
   end do
end program ex14_internal_read_after_external_read