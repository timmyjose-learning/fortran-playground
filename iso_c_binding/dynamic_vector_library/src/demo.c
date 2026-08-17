#include "./demo.h"

VectorT *vector_create() {
  VectorT *vec = malloc(sizeof *vec);
  if (!vec) {
    return NULL;
  }

  vec->size = 0;
  vec->capacity = 4;
  vec->data = malloc(vec->capacity * sizeof(double));

  return vec;
}

void vector_free(VectorT *vec) {
  if (vec) {
    if (vec->data) {
      free(vec->data);
    }
    free(vec);
  }
}

void vector_push(VectorT *vec, double val) {
  if (vec->size == vec->capacity) {
    vec->capacity *= 2;
    vec->data = realloc(vec->data, vec->capacity * sizeof(double));
  }

  vec->data[vec->size++] = val;
}

double *vector_data(VectorT *vec) { return vec->data; }

size_t vector_size(VectorT *vec) { return vec->size; }
size_t vector_capacity(VectorT *vec) { return vec->capacity; }
