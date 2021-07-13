#include <iostream>
#include <vector>

#include "mipp.h"


void mipp_add_int(int64_t *a) {
  *a = *a + 1;
}

void mipp_get_int_size(int32_t *int_sze){
  *int_sze = mipp::N<int64_t>();
}

void mipp_add_int_vectors(int64_t *a, int64_t *b, int64_t *c, int64_t dim){
  mipp::Reg<int64_t> ra;
  mipp::Reg<int64_t> rb;
  mipp::Reg<int64_t> rc;
  int n = mipp::N<int64_t>() * dim;
  for (int i = 0; i < n; i += mipp::N<int64_t>()) {
	ra.load(a + i); 
	rb.load(b + i); 
	rc = ra + rb;
	rc.store(c + i);
  }
}

void mipp_dgemm_kernel(double *a, double *b, double *c, int32_t M, int32_t N, int32_t K) {
  mipp::Reg<double> ra;
  mipp::Reg<double> rb;
  mipp::Reg<double> rc;
  double alpha=0.0;
  for(int i = 0; i < M; i += 1) {
    for(int l = 0; l < K; l += 1) {
      ra = a[ i * K + l ];
      double * c_int = c + i * N;
      double * b_int = b + l * N;
      for(int j = 0; j < N; j += mipp::N<double>()) {
	rc.load(c_int + j);
	rb.load(b_int + j);
	rc = mipp::fmadd(ra, rb, rc);
        rc.store(c_int + j);
      }
    }
  }
}

extern "C" {
  void mipp_add_int_c(int64_t *a){mipp_add_int(a);}
  void mipp_get_int_size_c(int32_t *a){mipp_get_int_size(a);}
  void mipp_add_int_vectors_c(int64_t *a, int64_t *b, int64_t *c, int64_t dim){mipp_add_int_vectors(a, b, c, dim);}
  void mipp_dgemm_kernel_c(double *a, double *b, double *c, int32_t M, int32_t N, int32_t K){mipp_dgemm_kernel(a, b, c, M, N, K);}
}
