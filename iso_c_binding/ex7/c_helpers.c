#include <stdlib.h>

double *c_make_array(int n) {
  double *arr = malloc(sizeof(double) * n);
  for (int i = 0; i < n; i++) {
    arr[i] = (double)(i + 1) * 10.0;
  }

  return arr;
}

void c_free_array(double *p) {
  if (p) {
    free(p);
  }
}