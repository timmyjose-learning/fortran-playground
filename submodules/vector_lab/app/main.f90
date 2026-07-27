program main
   use vector_api_m, only: vector_t,  make_countdown, reverse_in_place, map_vector, print_vector
   implicit none

   type(vector_t) :: v1, v2

   v1 = make_countdown(10)
   call print_vector(v1)

   call reverse_in_place(v1)
   call print_vector(v1)

   call map_vector(square, v1, v2)
   call print_vector(v2)

   if (allocated(v1%data)) then
      deallocate(v1%data)
   end if

   if (allocated(v2%data)) then
     deallocate(v2%data)
   end if

contains
   real function square(x)
      implicit none

      real, intent(in) :: x
      square = x * x
   end function
end program main
