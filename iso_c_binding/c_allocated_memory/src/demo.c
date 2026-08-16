#include <stdlib.h>

int *allocate_ints(int n) {
  int *ptr = malloc(sizeof(int) * n);
  for (int i = 0; i < n; i++) {
    ptr[i] = (i + 1) * 10;
  }
  return ptr;
}

void free_allocated_ints(int *p) {
  if (p) {
    free(p);
  }
}
