program main
  use mipp_interface_fortran
  implicit none
  integer*8 :: a, dim
  integer*8,dimension(:),allocatable :: veca, vecb, vecc

  dim = 16
  allocate(veca(dim))
  allocate(vecb(dim))
  allocate(vecc(dim))

  veca = 1
  vecb = 1
  vecc = 0

  print *,"Calling function "
  print *,"a = ",a
  call mipp_add_int_c(a)
  print *,"a = ",a
  print *,"Done"
  print *,"Calling function vectors "
  print *, veca
  call mipp_add_int_vectors_c(veca, vecb, vecc, dim)
  print *, vecc
  print *,"Done"
end program main
