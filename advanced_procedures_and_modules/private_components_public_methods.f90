module bank_account_m
   use, intrinsic :: iso_fortran_env, only: output_unit
   implicit none
   private

   type :: bank_account_t
      private
      character(len=:), allocatable :: name
      real :: balance = 0.0

   contains
      procedure, pass(this) :: deposit => deposit_amount, withdraw => withdraw_amount
      procedure, pass(this) :: print => print_account
   end type bank_account_t

   public :: bank_account_t, make_account

contains
   function make_account(name, init_bal) result(account)
      implicit none

      character(len=*), intent(in) :: name
      real, intent(in) :: init_bal
      type(bank_account_t) :: account

      account%name = trim(name)
      account%balance = init_bal
   end function make_account

   subroutine deposit_amount(this, amount)
      implicit none

      class(bank_account_t), intent(inout) :: this
      real, intent(in) :: amount

      if (amount < 0.0) then
         error stop 'negative amount for deposit'
      end if

      this%balance = this%balance + amount
   end subroutine deposit_amount

   subroutine withdraw_amount(this, amount)
      implicit none

      class(bank_account_t), intent(inout) :: this
      real, intent(in) :: amount

      if (amount < 0.0) then
         error stop 'negative amount for withdrawal'
      end if

      if (amount > this%balance) then
         error stop 'insufficient funds for withdrawal'
      end if

      this%balance = this%balance - amount
   end subroutine withdraw_amount

   subroutine print_account(this)
      implicit none

      class(bank_account_t), intent(in) :: this

      write (output_unit, *) 'Name = ', this%name, ', balance = ', this%balance
   end subroutine print_account
end module bank_account_m

program private_components_private_methdos
   use bank_account_m, only: bank_account_t, make_account
   implicit none

   type(bank_account_t) :: account

   account = make_account('Fred', 1000.0)

   call account%deposit(200.00)
   call account%withdraw(300.00)
   call account%print()

   ! This is not legal anymore
   !account%balance = 2000.00
end program private_components_private_methdos