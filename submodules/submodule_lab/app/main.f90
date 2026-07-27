program main
   use array_utils_m, only: alloc_fun_ret_t, make_countdown, print_array
   implicit none

   type(alloc_fun_ret_t) :: vals

   vals = make_countdown(11)
   call print_array(vals%arr)

   if (allocated(vals%arr)) then
      deallocate(vals%arr)
   end if
end program main
