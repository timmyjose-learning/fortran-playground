program main
   use, intrinsic :: iso_c_binding, only: c_int
   use demo_m, only: print_2d
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      integer(kind=c_int), dimension(2, 3) :: mat = reshape([1, 4, 2, 5, 3, 6], [2, 3])

      call print_2d(mat, 2_c_int, 3_c_int)
   end subroutine run_app
end program main
