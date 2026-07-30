program ex08_internal_files_and_iostat_end
   use, intrinsic :: iso_fortran_env, only: iostat_end, input_unit, output_unit, error_unit
   implicit none

   character(len=256) :: line
   integer :: num
   integer :: sum = 0
   integer :: iostat
   character(len=512) :: iomsg

   do
      write (output_unit, *) 'Enter an integer (Ctrl+D) to stop)'
      read (input_unit, '(A)', iostat=iostat, iomsg=iomsg) line

      if (iostat == iostat_end) exit

      if (iostat /= 0) then
         write (error_unit, *) 'Error reading line: ', iomsg
         cycle
      end if

      read (line, '(I5)', iostat=iostat) num

      if (iostat /= 0) then
         write (error_unit, *) 'Expected an integer'
         cycle
      end if

      sum = sum + num
   end do

   write (output_unit, *) 'Sum = ', sum
end program ex08_internal_files_and_iostat_end