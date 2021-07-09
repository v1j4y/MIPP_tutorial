program main
  use mipp_interface_fortran
  implicit none
  integer*8 :: a

  print *,"Calling function "
  print *,"a = ",a
  call mipp_add_int_c(a)
  print *,"a = ",a
  print *,"Done"
end program main
