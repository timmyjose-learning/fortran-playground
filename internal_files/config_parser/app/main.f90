program main
   use error_m, only: result_t, ERR_OK
   use settings_m, only: settings_t
   use parser_m, only: parse_config
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      character(len=128) :: config(5)
      type(settings_t) :: settings
      type(result_t) :: res

      config(1) = 'width = 800'
      config(2) = 'height = 600'
      config(3) = 'scale = 1.25'
      config(4) = 'debug = true'
      config(5) = 'title = config parsing demo'

      call parse_config(config, settings, res)

      if (res%code /= ERR_OK) then
         write (*, *) 'Error: ', res%msg
      else
         call display_settings(settings)
      end if
   end subroutine run_app

   subroutine display_settings(in_settings)
      implicit none

      type(settings_t), intent(in) :: in_settings

      write (*, '("width = ",I5)') in_settings%width
      write (*, '("height = ",I5)') in_settings%height
      write (*, '("scale = ",F8.3)') in_settings%scale
      write (*, '("debug = ",L)') in_settings%debug
      write (*, '("title = ",A)') in_settings%title
   end subroutine display_settings
end program main
