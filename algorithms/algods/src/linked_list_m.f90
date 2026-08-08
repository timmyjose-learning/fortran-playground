module linked_list_m
   use, intrinsic :: iso_fortran_env, only: error_unit
   implicit none
   private

   type :: node_t
      integer ::data
      type(node_t), pointer :: next => null()
   end type node_t

   type :: list_t
      private
      type(node_t), pointer :: head => null()

   contains
      procedure, pass(this) :: push_front
      procedure, pass(this) :: push_back
      procedure, pass(this) :: pop_front
      procedure, pass(this) :: pop_back

      procedure, pass(this) :: print => print_list
      procedure, pass(this) :: destroy => destroy_list

      procedure, pass(this) :: contains => list_contains
      procedure, pass(this) :: is_empty => list_is_empty

      procedure, pass(this) :: to_array => list_to_array
   end type list_t

   ! for the submodule which will implement list_t's procedures
   interface
      module subroutine push_front(this, val)
         implicit none
         class(list_t), intent(inout) :: this
         integer, intent(in) :: val
      end subroutine push_front

      module subroutine push_back(this, val)
         implicit none
         class(list_t), intent(inout) :: this
         integer, intent(in) :: val
      end subroutine push_back

      module function pop_front(this) result(int)
         implicit none
         class(list_t), intent(inout) :: this
         integer :: int
      end function pop_front

      module function pop_back(this) result(int)
         implicit none
         class(list_t), intent(inout) :: this
         integer :: int
      end function pop_back

      module subroutine print_list(this)
         implicit none
         class(list_t), intent(in) :: this
      end subroutine print_list

      module subroutine destroy_list(this)
         implicit none
         class(list_t), intent(inout) :: this
      end subroutine destroy_list

      module function list_contains(this, val) result(present)
         implicit none
         class(list_t), intent(in) :: this
         integer, intent(in) :: val
         logical :: present
      end function list_contains

      module function list_to_array(this) result(arr)
         implicit none
         class(list_t), intent(in) :: this
         integer, dimension(:), allocatable :: arr
      end function list_to_array

      module function list_is_empty(this) result(empty)
         implicit none
         class(list_t), intent(in) :: this
         logical :: empty
      end function list_is_empty
   end interface

   public :: list_t

end module linked_list_m

submodule (linked_list_m) list_impl_m
   implicit none

contains
   function make_node(val) result(node)
      implicit none

      integer, intent(in) :: val
      type(node_t), pointer :: node
      integer :: stat
      character(len=512) :: errmsg

      allocate(node, stat=stat, errmsg=errmsg)
      if (stat /= 0) then
         write (error_unit, *) 'Failed to allocate node: ' // errmsg
         error stop
      end if

      node%data = val
      node%next => null()
   end function make_node

   subroutine destroy_node(node)
      implicit none

      class(node_t), pointer, intent(inout) :: node

      if (associated(node)) then
         if (associated(node%next)) then
            deallocate(node%next)
         end if
         deallocate(node)
      end if
   end subroutine destroy_node

   module procedure push_front
end procedure push_front

module procedure push_back
end procedure push_back

module procedure pop_front
end procedure pop_front

module procedure pop_back
end procedure pop_back

module procedure print_list
end procedure print_list

module procedure destroy_list
end procedure destroy_list

module procedure list_contains
end procedure list_contains

module procedure list_to_array
end procedure list_to_array

module procedure list_is_empty
if (.not. associated(this%head)) then
  empty = .true.
else
  empty = .false.
end if
end procedure list_is_empty
end submodule list_impl_m
