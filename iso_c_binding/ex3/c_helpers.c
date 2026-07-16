double c_sum(int n, const double *arr) {
  double total = 0.0;

  for (int i = 0; i < n; i++) {
    total += arr[i];
  }

  return total;
}