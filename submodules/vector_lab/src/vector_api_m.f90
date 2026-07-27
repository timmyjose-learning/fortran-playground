module vector_api_m
   implicit none
   private

   public :: unary_real_fn, vector_t, make_countdown, reverse_in_place, map_vector, print_vector

   type :: vector_t
      real, dimension(:), allocatable :: data
   end type vector_t

   abstract interface
      real function unary_real_fn(x)
         implicit none
         real, intent(in) :: x
      end function unary_real_fn
   end interface

   interface
      module function make_countdown(n) result(v)
         implicit none
         integer, intent(in) :: n
         type(vector_t) :: v
      end function make_countdown

      module subroutine reverse_in_place(v)
         implicit none
         type(vector_t), intent(inout) :: v
      end subroutine reverse_in_place

      module subroutine map_vector(f, in_vec, out_vec)
         implicit none
         procedure(unary_real_fn) :: f
         type(vector_t), intent(in) :: in_vec
         type(vector_t), intent(out) :: out_vec
      end subroutine map_vector

      module subroutine print_vector(v)
         implicit none
         type(vector_t), intent(in) :: v
      end subroutine print_vector
   end interface
end module vector_api_m
