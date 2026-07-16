program ex02_c_modifies
   use, intrinsic :: iso_c_binding, only: c_int
   implicit none

   interface
      subroutine c_swap_ints(x, y) bind(C, name='c_swap_ints')
         import :: c_int

         integer(c_int) :: x, y
      end subroutine c_swap_ints
   end interface

   integer(c_int) :: a, b

   a = 2_c_int
   b = 3_c_int

   write (*, *) 'Before swap, a = ', a, ' and b = ', b
   call c_swap_ints(a, b)
   write (*, *) 'After swap, a = ', a, ' and b = ', b
end program ex02_c_modifies
