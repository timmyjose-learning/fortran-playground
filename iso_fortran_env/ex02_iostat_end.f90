program ex02_iostat_end
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit, error_unit, iostat_end
   implicit none

   integer :: n
   integer :: sum = 0
   integer :: iostat

   do
      write (output_unit, *) 'Enter a number (Ctrl + D to stop)'
      read (input_unit, *, iostat=iostat) n

      ! Ctrl+D was pressed
      if (iostat == iostat_end) exit

      if (iostat /= 0) then
         write(error_unit, *) 'A number was expected'
         cycle
      end if

      sum = sum + n
   end do

   write (output_unit, *) 'Sum = ', sum
end program ex02_iostat_end