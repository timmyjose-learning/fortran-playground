module demo_m
   use, intrinsic :: iso_c_binding, only: c_int, c_double
   implicit none
   private

   interface
      function sum(arr, n) bind(C, name='sum') result(res)
         import :: c_int, c_double
         implicit none

         real(kind=c_double), dimension(:), intent(in) :: arr
         integer(kind=c_int), intent(in), value :: n
         real(kind=c_double) :: res
      end function sum
   end interface
end module demo_m

