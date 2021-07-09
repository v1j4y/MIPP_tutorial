module mipp_interface_fortran
  use ISO_C_BINDING
  interface
     subroutine mipp_add_int_c(c) bind(c)
       use ISO_C_BINDING
       implicit none
       integer*8,intent(in) :: c
     end subroutine mipp_add_int_c
  end interface
end module mipp_interface_fortran
