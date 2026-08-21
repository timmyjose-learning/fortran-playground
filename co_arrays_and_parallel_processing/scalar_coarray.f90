program scalar_coarray
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      integer, codimension[*], save :: a
      integer :: i

      a = this_image()

      sync all

      if (this_image() == 1) then
         do i = 1, num_images()
            write (output_unit, '("a in image ",I0," is ",I0)') i, a[i]
         end do
      end if
   end subroutine run_app
end program scalar_coarray