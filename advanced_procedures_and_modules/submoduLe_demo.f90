module math_m
   implicit none
   private

   interface
      module function square(r) result(res)
         implicit none
         real, intent(in) :: r
         real :: res
      end function square
   end interface

   public :: square
end module math_m

submodule(math_m) math_impl_m
   implicit none

contains
   module procedure square
      implicit none
      res = r * r
   end procedure
end submodule math_impl_m

program submodule_demo
   use math_m, only: square
   implicit none

   real :: r = 2.78128
   write (*, *) square(r)
end program submodule_demo