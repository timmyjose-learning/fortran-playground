#include <stddef.h>
#include <stdlib.h>

typedef struct {
  double *data;
  size_t size;
  size_t capacity;
} VectorT;

VectorT *vector_create();
void vector_free(VectorT *);

void vector_push(VectorT *, double);

double *vector_data(VectorT *);
size_t vector_size(VectorT *);
size_t vector_capacity(VectorT *);
