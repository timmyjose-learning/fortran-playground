#include <stdio.h>

void print_2d(const int *mat, int rows, int cols) {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      printf("%d ", mat[j * rows + i]);
    }
    puts("");
  }
}
