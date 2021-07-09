#include <vector>

#include "mipp.h"


void mipp_add_int(int64_t *a) {
  *a = *a + 1;
}

void mipp_add_int_vectors(int64_t *a, int64_t *b, int64_t *c, int64_t dim){
  mipp::Reg<int64_t> ra;
  mipp::Reg<int64_t> rb;
  mipp::Reg<int64_t> rc;
  int n = mipp::N<int64_t>() * dim;
  std::vector<int64_t> veca(n);
  std::vector<int64_t> vecb(n);
  std::vector<int64_t> vecc(n);

  veca.assign(a, a + dim);
  vecb.assign(b, b + dim);
  vecc.assign(c, c + dim);

  int i = 0;
  printf("dim = %ld\n",dim);
  for(i = 0;i<=dim;i=i+4){
    printf("i=%d\n",i);
    ra.load(&veca[i*mipp::N<int64_t>()]);
    rb.load(&vecb[i*mipp::N<int64_t>()]);
    rc.load(&vecc[i*mipp::N<int64_t>()]);

    rc = ra + rb;
    rc.store(&vecc[(i+1)*mipp::N<int64_t>()]);
    c = &vecc[0];
    for(i=0;i<dim;++i)
      printf("(%ld) %ld\n",veca[i],c[i]);
  }
}

extern "C" {
  void mipp_add_int_c(int64_t *a){mipp_add_int(a);}
  void mipp_add_int_vectors_c(int64_t *a, int64_t *b, int64_t *c, int64_t dim){mipp_add_int_vectors(a, b, c, dim);}
}
