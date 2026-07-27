submodule(vector_api_m) vector_impl_m
   implicit none

contains
   module procedure make_countdown
      integer :: i
      integer :: stat
      character(len=512) :: errmsg

      if (n < 0) then
         error stop 'Cannot make a negatively sized vector'
      end if

      allocate(v%data(n), stat=stat, errmsg=errmsg)

      if (stat /= 0) then
         write (*, *) 'Error while allocating vector: ', errmsg
         error stop
      end if

      do i  = 1, size(v%data)
         v%data(i) = real(size(v%data) -i + 1)
      end do
   end procedure make_countdown

   module procedure reverse_in_place
      integer :: left, right
      real :: temp

      if (.not. allocated(v%data)) then
         error stop 'vector is not allocated'
      end if

      left = lbound(v%data, 1)
      right = ubound(v%data, 1)

      do while (left <= right)
         temp = v%data(left)
         v%data(left) = v%data(right)
         v%data(right) = temp
         left = left + 1
         right = right - 1
      end do
   end procedure reverse_in_place

   ! Cannot use `module procedure` here due to a compiler bug:
   ! https://gcc.gnu.org/bugzilla/show_bug.cgi?id=121204
   ! So falling back on the older style `module subroutine...` form.
   !module procedure map_vector
   !   integer :: i
   !   integer :: stat
   !   character(len=512) :: errmsg

   !   if (.not. allocated(in_vec%data)) then
   !      error stop 'vector is not allocated'
   !   end if

   !   allocate(out_vec%data(size(in_vec%data)), stat=stat, errmsg=errmsg)

   !   if (stat /= 0) then
   !      write (*, *) 'Error while allocating vector: ', errmsg
   !      error stop
   !   end if

   !   do i = 1, size(in_vec%data)
   !      out_vec%data(i) = f(in_vec%data(i))
   !   end do
   !end procedure map_vector

   module subroutine map_vector(f, in_vec, out_vec)
      procedure(unary_real_fn) :: f
      type(vector_t), intent(in) :: in_vec
      type(vector_t), intent(out) :: out_vec
      integer :: i
      integer :: stat
      character(len=512) :: errmsg

      if (.not. allocated(in_vec%data)) then
         error stop 'vector is not allocated'
      end if

      allocate(out_vec%data(size(in_vec%data)), stat=stat, errmsg=errmsg)

      if (stat /= 0) then
         write (*, *) 'Error while allocating vector: ', errmsg
         error stop
      end if

      do i = 1, size(in_vec%data)
         out_vec%data(i) = f(in_vec%data(i))
      end do
   end subroutine map_vector

   module procedure print_vector
      integer :: i
      if (.not. allocated(v%data)) then
         error stop 'vector is not allocated'
      end if

      write (*, '(*(F10.2))') (v%data(i), i = 1, size(v%data))
      write (*, *)
   end procedure print_vector
end submodule vector_impl_m
