typedef struct {
  int size;
  double *data;
} CVectorT;

void fill_data(CVectorT *vec) {
  for (int i = 0; i < vec->size; i++) {
    vec->data[i] = (i + 1) * 10.1;
  }
}
