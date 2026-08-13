module bank_m
   implicit none
   private

   type :: account_t
      private
      real :: balance
      character(len=:), allocatable :: owner
   contains
      procedure :: deposit
      procedure :: withdraw
      procedure :: get_balance

      procedure :: print
      generic :: write(formatted) => print
   end type account_t

   public :: account_t, make_account

contains
   function make_account(balance, owner) result(account)
      implicit none

      real, intent(in) :: balance
      character(len=*), intent(in) :: owner
      type(account_t) :: account

      account%balance = balance
      account%owner = owner
   end function make_account

   subroutine deposit(this, amount)
      implicit none

      class(account_t), intent(inout) :: this
      real, intent(in) :: amount

      this%balance = this%balance + amount
   end subroutine deposit

   subroutine withdraw(this, amount)
      implicit none

      class(account_t), intent(inout) :: this
      real, intent(in) :: amount

      this%balance = this%balance - amount
   end subroutine withdraw

   function get_balance(this) result(balance)
      implicit none

      class(account_t), intent(in) :: this
      real :: balance

      balance = this%balance
   end function get_balance

   subroutine print(this, unit, iotype, vlist, iostat, iomsg)
      implicit none

      class(account_t), intent(in) :: this
      integer, intent(in) :: unit
      character(len=*), intent(in) :: iotype
      integer, dimension(:), intent(in) :: vlist
      integer, intent(out) :: iostat
      character(len=*), intent(inout) :: iomsg

      if (.false.) then
         write (unit, *) iotype
         write (unit, *) vlist
      end if

      write (unit, '("{ Owner = ",A,", balance = ",F8.3," }")', iostat=iostat, iomsg=iomsg) this%owner, this%balance
   end subroutine print
end module bank_m

program bank_demo
   use, intrinsic :: iso_fortran_env, only: output_unit
   use bank_m, only: account_t, make_account
   implicit none

   type(account_t) :: account

   account = make_account(100.0, 'Bob')

   call account%deposit(10.0)
   write (output_unit, *) account

   call account%withdraw(20.0)
   write (output_unit, *) account

   call account%deposit(200.0)
   write (output_unit, *) 'Current balance = ', account%get_balance()
end program bank_demo