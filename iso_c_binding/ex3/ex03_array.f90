program ex03_array
   use, intrinsic :: iso_c_binding, only: c_int, c_double

   interface
      function c_sum(n, arr) bind(C, name='c_sum') result(res)
         import :: c_int, c_double
         implicit none

         integer(c_int), value :: n
         real(c_double), intent(in) :: arr(*) ! assume-size array
         real(c_double) :: res
      end function c_sum
   end interface

   real(c_double) :: arr(5) = [1.0_c_double, 2.0_c_double, 3.0_c_double, 4.0_c_double, 5.0_c_double]
   real(c_double) :: total

   total = c_sum(int(size(arr), c_int), arr)
   write (*, *) total
end program ex03_array
