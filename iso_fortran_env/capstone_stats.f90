program capstone_stats
   use, intrinsic :: iso_fortran_env, only: int64, real64, iostat_end, input_unit, output_unit, error_unit
   implicit none

   character(len=256) :: line
   integer :: count = 0
   real(kind=real64) :: x
   real(kind=real64) :: total = 0.0
   real(kind=real64) :: mean = 0.0
   integer :: iostat

   do
      write (output_unit, *) 'Enter an integer (Ctrl+D to stop)'
      read (input_unit, '(A)', iostat=iostat) line

      if (iostat == iostat_end) exit

      if (iostat /= 0) then
         write (error_unit, *) 'Read error'
         cycle
      end if

      if (len_trim(line) == 0) cycle

      read (line,*, iostat=iostat) x

      if (iostat /= 0) then
         write (error_unit, *) 'Invalid input: ' //  trim(line)
         cycle
      end if

      total = total + x
      count = count + 1
   end do

   mean = total / real(count, kind=real64)

   write (output_unit, *) 'Count = ', count
   write (output_unit, '(A,F8.3)') 'Total = ', total
   write (output_unit, *) 'Mean = ', mean
end program capstone_stats