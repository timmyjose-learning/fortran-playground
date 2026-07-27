module sum_utils_m
   implicit none
   private

   public :: sum_values

   interface
      module function sum_ints(arr) result(res)
         implicit none
         integer, dimension(:), intent(in) :: arr
         integer :: res
      end function sum_ints

      module function sum_reals(arr) result(res)
         implicit none
         real, dimension(:), intent(in) :: arr
         real :: res
      end function sum_reals
   end interface

   ! generic interface
   interface sum_values
      module procedure sum_ints
      module procedure sum_reals
   end interface
end module sum_utils_m

submodule(sum_utils_m) sum_utils_impl_m
   implicit none

contains
   module procedure sum_ints
      integer :: i

      res = 0
      do i = 1, size(arr)
         res = res + arr(i)
      end do
   end procedure sum_ints

   module procedure sum_reals
      integer :: i

      res = 0.0
      do i = 1, size(arr)
         res = res + arr(i)
      end do
   end procedure sum_reals
end submodule sum_utils_impl_m

program ex06_generic_interfaces_and_submodules
   use sum_utils_m, only: sum_values
   implicit none

   integer, dimension(5) :: iarr = [1, 2, 3, 4, 5]
   real, dimension(6) :: rarr = [1.0, 2.3, -3.11, 5.0, 0.0, -11.8]

   write (*, *) sum_values(iarr)
   write (*, *) sum_values(rarr)
end program ex06_generic_interfaces_and_submodules