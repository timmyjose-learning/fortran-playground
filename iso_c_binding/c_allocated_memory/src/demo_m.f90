module demo_m
   use, intrinsic :: iso_c_binding, only: c_int, c_ptr
   implicit none
   private

   interface
      function c_allocate_ints(n) bind(C, name='allocate_ints') result(ptr)
         import :: c_int, c_ptr
         implicit none

         integer(kind=c_int), intent(in), value :: n
         type(c_ptr) :: ptr
      end function c_allocate_ints

      subroutine c_free_allocated_ints(cptr) bind(C, name='free_allocated_ints')
         import :: c_ptr
         implicit none

         ! Always remember: Fortran is "pass-by-reference" by default
         type(c_ptr), intent(in), value :: cptr
      end subroutine c_free_allocated_ints
   end interface

   public :: c_allocate_ints, c_free_allocated_ints
end module demo_m
