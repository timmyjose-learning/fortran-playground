program main
   use, intrinsic :: iso_c_binding, only: c_char, c_null_char
   use demo_m, only: greet
   implicit none

   call run_app

contains
   subroutine run_app()
      implicit none

      character(kind=c_char, len=:), allocatable  :: name

      name = c_char_'Rufus' // c_null_char
      call greet(name)
      call greet(c_char_'Bob' // c_null_char)
   end subroutine run_app
end program main
