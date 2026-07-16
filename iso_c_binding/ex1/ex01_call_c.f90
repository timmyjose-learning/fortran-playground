program ex01_call_c
   use, intrinsic::iso_c_binding, only: c_int
   implicit none

   interface
      function c_add(x, y) bind(C, name="c_add") result(res)
         import :: c_int

         integer(c_int), value :: x, y
         integer(c_int) :: res
      end function c_add
   end interface

   integer(c_int) :: x, y

   x = 2_c_int
   y = 3_c_int

   write (*, *) c_add(x, y)

end program ex01_call_c
