module parser_m
   use error_m, only: result_t, ERR_PARSE
   use settings_m, only: settings_t
   implicit none
   private

   interface
      module subroutine parse_config(config, settings, res)
         implicit none

         character(len=*), intent(in) :: config(:)
         type(settings_t), intent(out) :: settings
         type(result_t), intent(out) :: res
      end subroutine parse_config
   end interface

   public :: parse_config
end module parser_m

submodule(parser_m) parser_impl_m
   implicit none

contains
   module procedure parse_config
      integer :: i
      integer :: eq_pos
      integer :: iostat
      character(len=:), allocatable :: key
      character(len=:), allocatable :: val_str
      integer :: num
      real :: r
      logical :: ok

      do i = 1, size(config)
         eq_pos = index(config(i), '=')

         if (eq_pos == 0) then
            res%code = ERR_PARSE
            res%msg = 'failed to parse line: ' // trim(config(i))
            return
         end if

         key = trim(adjustl(config(i)(:eq_pos - 1)))
         val_str = trim(adjustl(config(i)(eq_pos + 1:)))

         select case(key)
          case('width')
            call parse_integer(val_str, num, iostat)
            if (iostat /= 0) then
               res%code = ERR_PARSE
               res%msg = 'failed to parse width. Line: ' // trim(config(i))
               return
            end if
            settings%width = num

          case ('height')
            call parse_integer(val_str, num, iostat)
            if (iostat /= 0) then
               res%code = ERR_PARSE
               res%msg = 'failed to parse height. Line: ' // trim(config(i))
               return
            end if
            settings%height = num

          case ('scale')
            call parse_real(val_str, r, iostat)
            if (iostat /= 0) then
               res%code = ERR_PARSE
               res%msg = 'failed to parse scale. Line: ' // trim(config(i))
               return
            end if
            settings%scale = r

          case ('debug')
            call parse_logical(val_str, ok, iostat)
            if (iostat /= 0) then
               res%code = ERR_PARSE
               res%msg = 'failed to parse debug. Line: ' // trim(config(i))
               return
            end if
            settings%debug = ok
          case ('title')
            settings%title = trim(adjustl(val_str))
          case default
            res%code = ERR_PARSE
            res%msg = 'Unknown key: ' // key
            exit
         end select
      end do
   end procedure parse_config

   subroutine parse_integer(str, val, iostat)
      implicit none

      character(len=*), intent(in) :: str
      integer, intent(out) :: val
      integer, intent(out) :: iostat

      read (str, '(I5)', iostat=iostat) val
   end subroutine parse_integer

   subroutine parse_real(str, val, iostat)
      implicit none

      character(len=*), intent(in) :: str
      real, intent(out) :: val
      integer, intent(out) :: iostat

      read (str, '(F8.3)', iostat=iostat) val
   end subroutine parse_real

   subroutine parse_logical(str, val, iostat)
      implicit none

      character(len=*), intent(in) :: str
      logical, intent(out) :: val
      integer, intent(out) :: iostat

      read(str, '(L)', iostat=iostat) val
   end subroutine parse_logical
end submodule parser_impl_m
