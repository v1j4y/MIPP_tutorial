program main
  use mipp_interface_fortran
  implicit none
  integer*8 :: a, dim, i
  integer*4 :: sze, M, N, K, check
  real      :: start_time, finish_time, time_mipp, time_naive
  double precision,dimension(:,:),allocatable :: veca, vecb, vecc, vecd

  dim = 2
  sze = 0
  call mipp_get_int_size_c(sze)
  print *,"sze = ", sze
  M = 128
  N = 128
  K = 128
  print *, "M = ",M
  print *, "N = ",N
  print *, "K = ",K
  allocate(veca(M, K))
  allocate(vecb(K, N))
  allocate(vecc(M, N))
  allocate(vecd(M, N))

  call RANDOM_NUMBER(veca)
  call RANDOM_NUMBER(vecb)
  !veca = 1.0d0
  !vecb = 1.0d0
  vecc = 0.0d0

  print *,"Calling MIPP dgemm kernel "
  call CPU_TIME(start_time)
  call mipp_dgemm_kernel_c(veca, vecb, vecc, M, N, K)
  call CPU_TIME(finish_time)
  time_mipp = finish_time - start_time
  print '("Done Time (MIPP gemm) = ",f10.5," seconds.")',finish_time-start_time
  print *,"Calling NAIVE dgemm kernel "
  call CPU_TIME(start_time)
  call naive_gemm(veca, vecb, vecd, M, N, K)
  call CPU_TIME(finish_time)
  time_naive = finish_time - start_time
  print '("Done Time (NAIVE gemm) = ",f10.5," seconds.")',finish_time-start_time
  print '(" Gain = ",f10.5," Times.")', time_naive / time_mipp
  !check = 0
  !call test_matrix(veca, vecb, vecc, vecd, M, N, K, check)
  !do i = 1, M
  !   write(*,"(*(F6.2))")vecc(i,:)
  !end do
  deallocate(veca)
  deallocate(vecb)
  deallocate(vecc)
end program main

subroutine test_matrix(veca, vecb, vecc, vecd, M, N, K, check)
  implicit none
  integer*4, intent(in) :: M, N, K
  double precision,intent(in) :: veca(M,K)
  double precision,intent(in) :: vecb(K,N)
  double precision,intent(in) :: vecc(M,N)
  integer*4, intent(out) :: check
  double precision,intent(inout) :: vecd(M,N)
  integer :: i, j, l

  do i = 1, M
     do j = 1, N
        do l = 1, K
           vecd(j,i) = vecd(j,i) + veca(l,i)*vecb(j,l)
        end do
     end do
  end do
  !do i = 1, M
  !   write(*,"(*(F6.2))")vecd(i,:)-vecc(i,:)
  !end do

  ! Check
  do i = 1, M
     do j = 1, N
        if(dabs(vecd(i,j)-vecc(i,j)) > 1.0d-14) then
           check = 1
        endif
     end do
  end do
end subroutine test_matrix

subroutine naive_gemm(veca, vecb, vecd, M, N, K)
  implicit none
  integer*4, intent(in) :: M, N, K
  double precision,intent(in) :: veca(M,K)
  double precision,intent(in) :: vecb(K,N)
  double precision,intent(inout) :: vecd(M,N)
  integer :: i, j, l

  do i = 1, M
     do j = 1, N
        do l = 1, K
           vecd(j,i) = vecd(j,i) + veca(l,i)*vecb(j,l)
        end do
     end do
  end do
end subroutine naive_gemm
