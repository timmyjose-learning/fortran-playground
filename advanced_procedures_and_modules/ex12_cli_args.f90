program ex12_cli_args
   use, intrinsic :: iso_fortran_env, only: output_unit, error_unit
   implicit none

   integer :: i
   integer :: argc
   character(len=64) :: arg

   argc = command_argument_count()

   if (argc == 0) then
      write (error_unit, *) 'Usage: ./prog [arg]+'
   else
      do i = 1, argc
         call get_command_argument(i, arg)
         write (*, *) arg
      end do
   end if
end program ex12_cli_args