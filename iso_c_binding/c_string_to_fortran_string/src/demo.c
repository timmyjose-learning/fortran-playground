#include <stddef.h>

const char *get_c_string(size_t *length) {
  static const char str[] = "Salutations from C!";
  *length = sizeof str - 1; // visible length
  return str;
}
