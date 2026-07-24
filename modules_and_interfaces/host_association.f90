program host_association
   implicit none

   integer, parameter :: factor = 10
   integer :: num

   write (*, *) 'Enter an integer'
   read (*, *) num

   write (*, *) scale(num)

contains
   integer function scale(x) result(res)
      implicit none

      integer, intent(in) :: x
      ! `factor` is read from the parent scope.
      ! Fortran does not flag this as an error, but as a warning.
      ! Avoid shadowing thus at all costs.
      res = factor*x
   end function scale
end program host_association
