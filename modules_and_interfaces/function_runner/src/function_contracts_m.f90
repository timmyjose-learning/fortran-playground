module function_contracts_m
   implicit none

   abstract interface
      real function unary_real_fn(r)
         implicit none

         real, intent(in) :: r
      end function unary_real_fn
   end interface
end module function_contracts_m
