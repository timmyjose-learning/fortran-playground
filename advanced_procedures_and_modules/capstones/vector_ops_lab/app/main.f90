program main
   use, intrinsic :: iso_fortran_env, only: real64, input_unit, output_unit
   use vector_m, only: vector_t, print_vector, operator(+), operator(-), operator(*), operator(.dot.), norm

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(vector_t) :: v1, v2, res
      real(kind=real64) :: prod, norm_res

      write (output_unit, *) 'Enter the first vector'
      read (input_unit, *) v1%x, v1%y, v1%z

      write (output_unit, *) 'Enter the second vector'
      read (input_unit, *) v2%x, v2%y, v2%z


      write (output_unit, *) 'vector 1'
      call print_vector(v1)

      write (output_unit, *) 'vector 2'
      call print_vector(v2)

      res = v1 + v2
      write (output_unit, *) 'v1 + v2'
      call print_vector(res)

      res = v1 - v2
      write (output_unit, *) 'v1 - v2'
      call print_vector(res)

      res = v2 - v1
      write (output_unit, *) 'v2 - v1'
      call print_vector(res)

      res = -v1
      write (output_unit, *) '-v1'
      call print_vector(res)

      res = v1 * v2
      write (output_unit, *) 'v1 * v2'
      call print_vector(res)

      res = 10.0_real64 * v1
      write (output_unit, *) '10.0 * v1'
      call print_vector(res)

      res = v1 * 100.0_real64
      write (output_unit, *) 'v1 * 100.0'
      call print_vector(res)

      prod = v1 .dot. v2
      write (output_unit, *) 'v1 .dot. v2'
      write (output_unit, *) 'Dot product = ', prod

      norm_res = norm(v1, v2)
      write (output_unit, *) 'norm(v1, v2)'
      write (output_unit, *) norm_res
   end subroutine run_app
end program main
