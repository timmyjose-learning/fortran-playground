module algods
  implicit none
  private

  public :: say_hello
contains
  subroutine say_hello
    print *, "Hello, algods!"
  end subroutine say_hello
end module algods
