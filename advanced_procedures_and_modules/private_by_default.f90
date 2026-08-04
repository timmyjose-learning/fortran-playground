module stats_m
   implicit none
   private

   public :: mean

contains
   function mean(arr) result(m)
      implicit none

      real, dimension(:), intent(in) :: arr
      real :: s
      real :: m

      s = hidden_sum(arr)
      m = s / real(size(arr))
   end function mean

   function hidden_sum(arr) result(s)
      implicit none

      real, dimension(:), intent(in) :: arr
      real :: s

      s = sum(arr)
   end function hidden_sum
end module stats_m

program private_by_default
   use stats_m, only: mean
   implicit none

   real, dimension(5) :: arr = (/ 1.0, 2.0, 3.0, 4.0, 5.0 /)

   write (*, *) mean(arr)
end program private_by_default

