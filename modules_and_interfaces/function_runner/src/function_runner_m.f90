module function_runner_m
   use function_contracts_m, only: unary_real_fn
   implicit none
   private

   public :: print_table, map_array
contains
   subroutine newline()
      implicit none

      write (*, *)
   end subroutine newline

   subroutine print_table(f, arr)
      implicit none

      procedure(unary_real_fn) :: f
      real, dimension(:), intent(in) :: arr
      integer :: i

      do i = 1, size(arr)
         write (*, '(F8.3,A,F8.3)') arr(i), ' => ', f(arr(i))
      end do
      call newline()
   end subroutine print_table

   subroutine map_array(f, in_arr, out_arr)
      implicit none

      procedure(unary_real_fn) :: f
      real, dimension(:), intent(in) :: in_arr
      real, dimension(:), intent(out) :: out_arr
      integer :: i

      if (size(in_arr) /= size(out_arr)) then
         error stop 'Array size mismatch'
      end if

      out_arr = [(f(in_arr(i)), i=1, size(in_arr))]
   end subroutine map_array
end module function_runner_m
