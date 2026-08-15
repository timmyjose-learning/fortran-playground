program main
   use, intrinsic :: iso_fortran_env, only: output_unit
   use diagnostics_m, only: diagnostic_t, make_diagnostic, make_span, sink_t, stderr_sink_t, &
      memory_sink_t,  make_stderr_sink, make_memory_sink
   implicit none

   call run_app()

contains
   subroutine run_app()
      implicit none

      type(diagnostic_t) :: d1
      type(diagnostic_t) :: d2
      type(stderr_sink_t) :: stderr_sink
      type(memory_sink_t) :: memory_sink

      d1 = make_diagnostic('error', make_span(3, 14), 'expected expression')
      d2 = make_diagnostic('warning', make_span(8, 2), 'unused variable x')

      stderr_sink = make_stderr_sink()
      memory_sink = make_memory_sink(10)

      write (output_unit, *) 'stderr sink:'
      call emit_two(stderr_sink, d1, d2)
      call stderr_sink%describe()

      write (output_unit, *) 'memory sink:'
      call emit_two(memory_sink, d1, d2)
      call memory_sink%describe()
      call memory_sink%print_all()
   end subroutine run_app

   subroutine emit_two(sink, a, b)
      implicit none

      class(sink_t), intent(inout) :: sink
      type(diagnostic_t), intent(in) :: a
      type(diagnostic_t), intent(in) :: b

      call sink%emit(a)
      call sink%emit(b)

      write (output_unit, *) 'sink count = ', sink%count()
   end subroutine emit_two
end program main
