program ex12_character_array_as_multiple_records
   implicit none

   character(len=24) :: records(3)
   integer :: a, b, c

   records(1) = '10'
   records(2) = '20'
   records(3) = '30'

   read (records, *) a, b, c
   write (*, *) a, b, c
end program ex12_character_array_as_multiple_records

