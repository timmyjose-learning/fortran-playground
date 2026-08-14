module expr_m
   implicit none
   private

   type, abstract :: expr_t
   contains
      procedure :: set_real => unimplemented_set_real
      procedure :: set_char => unimplemented_set_char
      generic :: set => set_real, set_char
   end type expr_t

   type, extends(expr_t) :: num_expr_t
      private
      real :: value
   contains
      procedure :: set_real => set_num
      procedure :: get_num
   end type num_expr_t

   type, extends(expr_t) :: str_expr_t
      private
      character(len=:), allocatable :: str
   contains
      procedure :: set_char => set_str
      procedure :: get_str
   end type str_expr_t

   public :: expr_t, num_expr_t, str_expr_t

contains
   subroutine unimplemented_set_real(this, val)
      implicit none
      class(expr_t), intent(inout) :: this
      real, intent(in) :: val

      if (.false.) then
         write (*, *) val
      end if

      error stop 'unimplemented'
   end subroutine unimplemented_set_real

   subroutine unimplemented_set_char(this, val)
      implicit none
      class(expr_t), intent(inout) :: this
      character(len=*), intent(in) :: val

      if (.false.) then
         write (*, *) val
      end if

      error stop 'unimplementd'
   end subroutine unimplemented_set_char

   subroutine set_num(this, val)
      implicit none

      class(num_expr_t), intent(inout) :: this
      real, intent(in) :: val

      this%value = val
   end subroutine set_num

   subroutine set_str(this, val)
      implicit none

      class(str_expr_t), intent(inout) :: this
      character(len=*), intent(in) :: val

      this%str = val
   end subroutine set_str

   function get_num(this) result(num)
      implicit none

      class(num_expr_t), intent(in) :: this
      real :: num

      num = this%value
   end function get_num

   function get_str(this) result(str)
      implicit none

      class(str_expr_t), intent(in) :: this
      character(len=:), allocatable :: str

      str = this%str
   end function get_str
end module expr_m

program select_type
   use, intrinsic :: iso_fortran_env, only: output_unit, error_unit
   use expr_m, only: expr_t, num_expr_t, str_expr_t
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      class(expr_t), allocatable :: p
      integer :: stat
      character(len=512) :: errmsg

      allocate(num_expr_t :: p, stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)
      call p%set(3.141593)
      call process(p)

      deallocate(p, stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)

      allocate(str_expr_t :: p, stat=stat, errmsg=errmsg)
      call check_mem(stat, errmsg)
      call p%set('Hello, world!')
      call process(p)
   end subroutine run_app

   subroutine process(expr)
      implicit none

      class(expr_t), intent(in) :: expr

      select type(expr)
       type is (num_expr_t)
         write (output_unit, *) 'number value = ', expr%get_num()
       type is (str_expr_t)
         write (output_unit, *) 'string value = ', expr%get_str()
       class default
         write (error_unit, *) 'Unrecognised type'
      end select
   end subroutine process

   subroutine check_mem(stat, errmsg)
      implicit none

      integer, intent(in) :: stat
      character(len=*), intent(in) :: errmsg

      if (stat /= 0) then
         write (error_unit, *) 'Allocation/Deallocation failed: ' // errmsg
         error stop
      end if
   end subroutine check_mem
end program select_type