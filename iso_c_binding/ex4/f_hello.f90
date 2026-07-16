subroutine f_hello() bind(C, name='f_hello')
   implicit none

   write (*, *) 'Hello from Fortran!'
end subroutine f_hello
