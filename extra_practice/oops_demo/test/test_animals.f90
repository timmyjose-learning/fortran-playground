program test_animals
   use animals_m, only: animal_t, cat_t, dog_t, make_cat, make_dog
   implicit none

   call run_tests()

contains
   subroutine run_tests()
      implicit none

      call test_animal()
      call test_cat()
      call test_dog()
      call test_cat_concrete()
      call test_dog_concrete()
   end subroutine run_tests

   subroutine test_animal()
      implicit none

      ! we need to use allocatable/pointer polymorphic types
      ! when declaring with the abstract base class type
      class(animal_t), allocatable :: cat
      class(animal_t), allocatable :: dog

      allocate(cat, source=make_cat(123))
      dog = make_dog(999)

      call cat%make_sound()
      call dog%make_sound()
   end subroutine test_animal

   subroutine test_cat()
      implicit none

      class(animal_t), allocatable :: cat

      allocate(cat, source=make_cat(1))

      call cat%make_sound()
      call cat%animate()
   end subroutine test_cat

   subroutine test_dog()
      implicit none

      class(animal_t), allocatable :: dog

      dog = make_dog(2)
      call dog%make_sound()
      call dog%animate()
   end subroutine test_dog

   subroutine test_cat_concrete()
      implicit none

      type(cat_t) :: cat

      cat = make_cat(3)
      call cat%make_sound()
      call cat%animate()
   end subroutine test_cat_concrete

   subroutine test_dog_concrete()
      implicit none

      type(dog_t) :: dog

      dog = make_dog(4)
      call dog%make_sound()
      call dog%animate()
   end subroutine test_dog_concrete
end program test_animals
