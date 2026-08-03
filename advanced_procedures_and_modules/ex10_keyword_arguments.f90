program ex10_keyword_arguments
   implicit none

   call describe_book(id=1, title='War and Peace', author='Leo Tolstoy')
   call describe_book(title='Dubliners', id = 2, author='James Joyce')

contains
   subroutine describe_book(id, title, author)
      implicit none

      integer, intent(in) :: id
      character(len=*), intent(in) :: title
      character(len=*), intent(in) :: author

      write (*, *) 'Id: ', id, ', title = ', title, ', author = ', author
   end subroutine describe_book
end program ex10_keyword_arguments