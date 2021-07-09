module mipp_interface_fortran
  use ISO_C_BINDING
  interface
     subroutine mipp_add_int_c(c) bind(c)
       use ISO_C_BINDING
       implicit none
       integer*8,intent(in) :: c
     end subroutine mipp_add_int_c
     subroutine mipp_get_int_size_c(c) bind(c)
       use ISO_C_BINDING
       implicit none
       integer*4,intent(in) :: c
     end subroutine mipp_get_int_size_c
     subroutine mipp_add_int_vectors_c(a, b, c, dim) bind(c)
       use ISO_C_BINDING
       implicit none
       integer*8,intent(in),value :: dim
       integer*8,intent(in)    :: a(dim)
       integer*8,intent(in)    :: b(dim)
       integer*8,intent(inout) :: c(dim)
     end subroutine mipp_add_int_vectors_c
     subroutine mipp_dgemm_kernel_c(a, b, c, M, N, K) bind(c)
       use ISO_C_BINDING
       implicit none
       integer*4,intent(in),value :: M, N, K
       double precision,intent(in)    :: a(M, K)
       double precision,intent(in)    :: b(K, N)
       double precision,intent(inout) :: c(M, N)
     end subroutine mipp_dgemm_kernel_c
  end interface
end module mipp_interface_fortran
