module animal_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: animal_t
      private
      character(len=:), allocatable :: name
   contains
      procedure :: speak => animal_speak
   end type animal_t

   type, extends(animal_t) :: dog_t
   contains
      procedure :: speak => dog_speak
   end type dog_t

   public :: animal_t, dog_t, make_animal, make_dog, call_speak_exact, call_speak_poly

contains
   function make_animal(name) result(animal)
      implicit none

      character(len=*), intent(in) :: name
      type(animal_t) :: animal

      animal%name = name
   end function make_animal

   function make_dog(name) result(dog)
      implicit none

      character(len=*), intent(in) :: name
      type(dog_t) :: dog

      dog%name = name
   end function make_dog

   subroutine animal_speak(this)
      implicit none

      class(animal_t), intent(in) :: this

      write (output_unit, *) this%name, ' makes a sound'
   end subroutine animal_speak

   subroutine dog_speak(this)
      implicit none

      class(dog_t), intent(in) :: this

      write (output_unit, *) this%name, ' says woof!'
   end subroutine dog_speak

   subroutine call_speak_exact(animal)
      implicit none

      type(animal_t), intent(in) :: animal

      call animal%speak()
   end subroutine call_speak_exact

   subroutine call_speak_poly(animal)
      implicit none

      class(animal_t), intent(in) :: animal

      call animal%speak()
   end subroutine call_speak_poly
end module animal_m

program type_vs_class
   use animal_m, only: animal_t, dog_t, make_animal, make_dog,  call_speak_exact, call_speak_poly
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(animal_t) :: animal
      type(dog_t) :: dog

      animal = make_animal('Animal')
      dog = make_dog('Bruno')

      call call_speak_exact(animal)
      call call_speak_poly(animal)
      call call_speak_poly(dog)
   end subroutine run_app
end program type_vs_class