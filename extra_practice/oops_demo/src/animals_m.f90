module animals_m
   use, intrinsic:: iso_fortran_env, only: output_unit
   implicit none
   private

   type, abstract :: animal_t
      integer :: id

   contains
      procedure(unary_sub), deferred :: make_sound
      procedure(unary_sub), deferred :: animate
   end type animal_t

   abstract interface
      subroutine unary_sub(this)
         import :: animal_t
         implicit none

         class(animal_t), intent(in) :: this
      end subroutine unary_sub
   end interface

   type, extends(animal_t) :: cat_t
   contains
      procedure, pass(this) :: make_sound => meow
      procedure, pass(this) :: animate => prance
   end type cat_t

   type, extends(animal_t) :: dog_t
   contains
      procedure, pass(this) :: make_sound => bark
      procedure, pass(this) :: animate => wag_tail
   end type dog_t

   ! for the submodule to pick up the correct type signatures
   interface
      module subroutine meow(this)
         implicit none
         class(cat_t), intent(in) :: this
      end subroutine meow

      module subroutine prance(this)
         implicit none
         class(cat_t), intent(in) :: this
      end subroutine prance

      module subroutine bark(this)
         implicit none
         class(dog_t), intent(in) :: this
      end subroutine bark

      module subroutine wag_tail(this)
         implicit none
         class(dog_t), intent(in) :: this
      end subroutine wag_tail
   end interface

   public :: animal_t, cat_t, dog_t, make_cat, make_dog

contains
   function make_cat(id) result(cat)
      implicit none

      integer, intent(in) :: id
      type(cat_t) :: cat

      cat%id = id
   end function make_cat

   function make_dog(id) result(dog)
      implicit none

      integer, intent(in) :: id
      type(dog_t) :: dog

      dog%id = id
   end function make_dog
end module animals_m

submodule(animals_m) animals_impl_m
   implicit none

contains
   module procedure meow
      write (output_unit, '(I5, " says ","''Meow!''")') this%id
   end procedure meow

   module procedure prance
      write (output_unit, '(I5," prances")') this%id
   end procedure prance

   module procedure bark
      write (output_unit, '(I5, " says ","''Woof!''")') this%id
   end procedure bark

   module procedure wag_tail
      write (output_unit, '(I5," wags tail")') this%id
   end procedure wag_tail
end submodule animals_impl_m
