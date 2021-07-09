#include "mipp.h"


void mipp_add_int(int64_t *a) {
  *a = *a + 1;
}

extern "C" {
  void mipp_add_int_c(int64_t *a){mipp_add_int(a);}
}
