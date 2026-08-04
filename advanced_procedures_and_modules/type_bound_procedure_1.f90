module book_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: book_t
      integer :: id
      character(len=:), allocatable:: title
      character(len=:), allocatable :: author

   contains
      ! PASS is the default, so the following is the same as:
      ! procedure, pass :: print => print_book
      procedure :: print => print_book
   end type book_t

   public :: book_t

contains
   subroutine print_book(this)
      implicit none

      class(book_t), intent(in) :: this

      write (output_unit, *) 'Id = ', this%id
      write (output_unit, *) 'Title = ', this%title
      write (output_unit, *) 'Author = ', this%author
   end subroutine print_book
end module book_m

program type_bound_procedure_1
   use book_m, only: book_t
   implicit none

   type(book_t) :: book

   book%id = 1
   book%title = 'War and Peace'
   book%author = 'Leo Tolstoy'

   call book%print()
end program type_bound_procedure_1