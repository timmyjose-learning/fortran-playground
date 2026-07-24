program internal_procedures
   implicit none

   integer :: num

   write (*, *) 'Enter an integer'
   read (*, *) num

   write (*, *) double_then_add_one(num)

contains
   integer function double(n) result(res)
      implicit none

      integer, intent(in) :: n
      res = n*2
   end function double

   integer function double_then_add_one(n) result(res)
      implicit none

      integer, intent(in) :: n
      res = double(n) + 1
   end function double_then_add_one
end program internal_procedures
