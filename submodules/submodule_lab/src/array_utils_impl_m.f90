submodule(array_utils_m) array_utils_impl_m
   implicit none

contains
   module procedure make_countdown
      integer :: stat
      character(len=512) :: errmsg
      integer :: i

      allocate(res%arr(n), stat=stat, errmsg=errmsg)

      if (stat /= 0) then
         write (*, *) 'Error while allocating array: ', errmsg
         error stop
      end if

      do i = 1, size(res%arr)
         res%arr(i) = real(size(res%arr) - i + 1)
      end do
   end procedure make_countdown

   module procedure print_array
      integer :: i

      write (*, '(*(F10.2))') (arr(i), i = 1, size(arr))
      write (*, *)
   end procedure print_array
end submodule array_utils_impl_m
