module animal_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none

   type, abstract :: animal_t
   contains
      procedure(speak_sub), deferred :: speak
   end type animal_t

   abstract interface
      subroutine speak_sub(this)
         import :: animal_t
         implicit none

         class(animal_t), intent(in) :: this
      end subroutine speak_sub
   end interface

   type, extends(animal_t) :: dog_t
   contains
      procedure :: speak => bark
   end type dog_t

   type, extends(animal_t) :: cat_t
   contains
      procedure :: speak => meow
   end type cat_t

   public :: animal_t, make_animal

contains
   function make_animal(type) result(animal)
      implicit none

      character(len=*), intent(in) :: type
      class(animal_t), allocatable :: animal

      select case(trim(type))
       case('dog')
         allocate(dog_t :: animal)
       case('cat')
         allocate(cat_t :: animal)
       case default
         error stop 'unknown type of animal'
      end select
   end function make_animal

   subroutine bark(this)
      implicit none

      class(dog_t), intent(in) :: this

      write (output_unit, *) 'Woof!'
   end subroutine bark

   subroutine meow(this)
      implicit none

      class(cat_t), intent(in) :: this

      write (output_unit, *) 'Meow!'
   end subroutine meow
end module animal_m


program factory_method
   use animal_m, only: animal_t, make_animal
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      class(animal_t), allocatable :: animal

      animal = make_animal('dog')
      call animal%speak()

      ! be defensive - not an anti-pattern, and helps avoid compiler bugs
      if (allocated(animal)) then
         deallocate(animal)
      end if

      animal = make_animal('cat')
      call animal%speak()
   end subroutine run_app
end program factory_method