module demo_m
   use, intrinsic :: iso_c_binding, only: c_null_ptr, c_ptr, c_size_t, c_double, c_int, &
      c_associated, c_f_pointer
   implicit none
   private

   type :: vector_handle_t
      type(c_ptr) :: ptr = c_null_ptr
   contains
      procedure :: init => vec_init
      procedure :: push => vec_push
      procedure :: free => vec_free
      procedure :: get_array => vec_get_array
   end type vector_handle_t

   interface
      function c_vector_create() bind(C, name='vector_create') result(vec)
         import :: c_ptr
         implicit none

         type(c_ptr) :: vec
      end function c_vector_create

      subroutine c_vector_free(vec) bind(C, name='vector_free')
         import :: c_ptr
         implicit none

         type(c_ptr), intent(in), value :: vec
      end subroutine c_vector_free

      subroutine c_vector_push(vec, val) bind(C, name='vector_push')
         import :: c_ptr, c_double
         implicit none

         type(c_ptr), intent(in), value :: vec
         real(kind=c_double), intent(in), value :: val
      end subroutine c_vector_push

      function c_vector_data(vec) bind(C, name='vector_data') result(data)
         import :: c_ptr
         implicit none

         type(c_ptr), intent(in), value :: vec
         type(c_ptr) :: data
      end function c_vector_data

      function c_vector_size(vec) bind(C, name='vector_size') result(size)
         import :: c_ptr, c_int
         implicit none

         type(c_ptr), intent(in), value :: vec;
         integer(kind=c_int) :: size
      end function c_vector_size

      function c_vector_capacity(vec) bind(C, name='vector_capacity') result(capacity)
         import :: c_ptr, c_int
         implicit none

         type(c_ptr), intent(in), value :: vec
         integer(kind=c_int) :: capacity
      end function c_vector_capacity
   end interface

   public :: vector_handle_t

contains
   subroutine vec_init(this)
      implicit none

      class(vector_handle_t), intent(out) :: this

      this%ptr = c_vector_create()
   end subroutine vec_init

   subroutine vec_free(this)
      implicit none

      class(vector_handle_t), intent(inout) :: this

      if (c_associated(this%ptr)) then
         call c_vector_free(this%ptr)
         this%ptr = c_null_ptr
      end if
   end subroutine vec_free

   function vec_get_array(this) result (arr)
      implicit none

      class(vector_handle_t), intent(in) :: this
      real(kind=c_double), dimension(:), pointer :: arr
      integer(kind=c_size_t) :: sz
      type(c_ptr) :: data_ptr

      arr => null()
      sz = c_vector_size(this%ptr)
      data_ptr = c_vector_data(this%ptr)
      call c_f_pointer(data_ptr, arr, [sz])
   end function vec_get_array

   subroutine vec_push(this, val)
      implicit none

      class(vector_handle_t), intent(inout) :: this
      real(kind=c_double), intent(in) :: val

      call c_vector_push(this%ptr, val)
   end subroutine vec_push
end module demo_m
