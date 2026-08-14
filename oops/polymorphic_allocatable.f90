module animal_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: animal_t
   contains
      procedure :: speak => make_animal_sound
   end type animal_t

   type, extends(animal_t) :: dog_t
   contains
      procedure :: speak => bark
   end type dog_t

   type, extends(animal_t) :: cat_t
   contains
      procedure :: speak => meow
   end type cat_t

   public :: animal_t, dog_t, cat_t

contains
   subroutine make_animal_sound(this)
      implicit none

      class(animal_t), intent(in) :: this

      write (output_unit, *) 'makes generic animal sounds'
   end subroutine make_animal_sound

   subroutine bark(this)
      implicit none

      class(dog_t), intent(in) :: this

      write (output_unit, *) 'barks'
   end subroutine bark

   subroutine meow(this)
      implicit none

      class(cat_t), intent(in) :: this

      write (output_unit, *) 'meows'
   end subroutine meow
end module animal_m

program polymorphic_allocatable
   use, intrinsic :: iso_fortran_env, only: error_unit
   use animal_m, only: animal_t, dog_t, cat_t
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      class(animal_t), allocatable :: pet
      integer :: stat
      character(len=512) :: errmsg

      allocate(pet)
      call pet%speak()

      deallocate(pet, stat=stat, errmsg=errmsg)
      if (stat /= 0) then
         write (error_unit, *) 'Failed to deallocate pet: ' // errmsg
         error stop
      end if

      allocate(dog_t :: pet)
      call pet%speak()

      deallocate(pet, stat=stat, errmsg=errmsg)
      if (stat /= 0) then
         write (error_unit, *) 'Failed to deallocate dog: ' // errmsg
         error stop
      end if

      allocate(cat_t :: pet)
      call pet%speak()
   end subroutine run_app
end program polymorphic_allocatable