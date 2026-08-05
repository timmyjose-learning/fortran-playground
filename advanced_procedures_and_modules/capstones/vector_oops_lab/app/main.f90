program main
   use, intrinsic :: iso_fortran_env, only: input_unit, output_unit, real64
   use vector_m, only: vector_t, make_vector, norm

   call run_app()

contains
   subroutine run_app()
      implicit none

      real(kind=real64) :: x, y, z
      type(vector_t) :: v1, v2, res
      real(kind=real64) :: prod_res
      real(kind=real64) :: norm_res

      write (output_unit, *) 'Enter the first vector'
      read (input_unit, *) x, y, z
      v1 = make_vector(x, y, z)

      write (output_unit, *) 'Enter the second vector'
      read (input_unit, *) x, y, z
      v2 = make_vector(x, y, z)

      write (output_unit, *) 'v1'
      call v1%print()
      write (output_unit, *) 'v2'
      call v2%print()

      res = v1 + v2
      write (output_unit, *) 'v1 + v2'
      call res%print()

      res = v1 - v2
      write (output_unit, *) 'v1 - v2'
      call res%print()

      res = v2 - v1
      write (output_unit, *) 'v2 - v1'
      call res%print()

      res = v1 * v2
      write (output_unit, *) 'v1 * v2'
      call res%print()

      res = 10.0_real64 * v1
      write (output_unit, *) '10.0 * v1'
      call res%print()

      res = v1 * 100.0_real64
      write (output_unit, *) 'v1 * 100.0'
      call res%print()

      res = -v1
      write (output_unit, *) '-v1'
      call res%print()

      prod_res = v1 .dot. v2
      write (output_unit, *) 'v1 .dot. v2 = ', prod_res

      norm_res = norm(v1, v2)
      write (output_unit, *) 'norm(v1, v2) = ', norm_res
   end subroutine run_app
end program main
