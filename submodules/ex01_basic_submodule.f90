module greetings_m
   implicit none
   private

   public :: say_hello

   interface
      module subroutine say_hello(name)
         implicit none
         character(len=*), intent(in) :: name
      end subroutine say_hello
   end interface
end module greetings_m

submodule(greetings_m) greetings_impl_m
   implicit none

contains
   module procedure say_hello
   write (*, '(A,A)') 'Hello, ', name
   end procedure
end submodule greetings_impl_m

program ex01_basic_submodule
   use greetings_m, only: say_hello
   implicit none

   call say_hello('Bob')
end program ex01_basic_submodule
