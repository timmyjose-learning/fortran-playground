program linked_list
   implicit none

   type :: node_t
      integer :: value
      type(node_t), pointer :: next => null()
   end type node_t

   type(node_t), pointer :: head => null()

   call push_front(head, 1)
   call push_front(head, 2)
   call push_front(head, 3)
   call push_front(head, 4)
   call push_front(head, 5)

   call print_list(head)

   call destroy_list(head)

contains
   subroutine push_front(hd, val)
      implicit none

      type(node_t), pointer, intent(inout) :: hd
      integer, intent(in):: val
      type(node_t), pointer :: new_node

      if (.not. associated(head)) then
         allocate (hd)
         head%value = val
         head%next => null()
      else
         allocate (new_node)
         new_node%value = val
         new_node%next => hd
         hd => new_node
      end if
   end subroutine push_front

   subroutine print_list(hd)
      implicit none

      type(node_t), pointer, intent(in) :: hd
      type(node_t), pointer :: curr

      curr => hd

      do while (associated(curr))
         write (*, '(I5)', advance='no') curr%value
         curr => curr%next
      end do
      write (*, *)
   end subroutine print_list

   subroutine destroy_list(hd)
      implicit none

      type(node_t), pointer, intent(inout) :: hd
      type(node_t), pointer :: curr => null(), next => null()

      curr => hd

      do while (associated(curr))
         next => curr%next
         deallocate (curr)
         curr => next
      end do

      nullify (hd)
   end subroutine destroy_list
end program linked_list
