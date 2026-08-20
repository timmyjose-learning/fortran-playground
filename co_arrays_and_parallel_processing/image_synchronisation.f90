program image_synchronisation
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      ! Co-arrays must be `save` so that the value can be persisted and accessed even if the image is stopped, or the value has gone
      ! out of scope
      ! Variables in `program` and `module` sections are automatically `save`, but in `subroutine`S, they must be explicitly declared as
      ! `save`
      integer, codimension[*], save :: a
      integer :: i
      integer :: m
      integer :: stat
      character(len=512) :: errmsg

      ! Only the master image (image number 1) can read input
      if (this_image() == 1) then
         write (output_unit, *) 'Enter a number'
         read (input_unit, *) m

         do i = 1, num_images()
            a[i] = i * m
         end do
      end if

      ! make sure to sync
      sync all (stat=stat, errmsg=errmsg)
      if (stat /= 0) then
         error stop 'Error: ' // errmsg
      end if

      write (output_unit, '("Value of a in image ",I0," is ",I0)') this_image(), a
   end subroutine run_app
end program image_synchronisation