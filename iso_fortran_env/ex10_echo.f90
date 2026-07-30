program ex10_echo
   use, intrinsic :: iso_fortran_env, only: iostat_end, iostat_eor, input_unit, output_unit, error_unit
   implicit none

   character(len=1) :: ch
   integer :: iostat

   write (output_unit, *) 'Enter a line'

   do
      read (input_unit, '(A)', advance='no', iostat=iostat) ch

      ! EOF
      if (iostat == iostat_end) exit

      ! EOR - end of record
      if (iostat == iostat_eor) then
         write (output_unit, *)
         write (output_unit, *) 'End of record'
         exit
      end if

      if (iostat /= 0) then
         write (error_unit,*) 'Error while reading input'
         error stop
      end if

      write (output_unit, '(A)', advance='no') ch
   end do
end program ex10_echo