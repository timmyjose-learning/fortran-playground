#include <math.h>

typedef struct {
  double x;
  double y;
} point_t;

double c_line_length(const point_t *p1, const point_t *p2) {
  double dx = p1->x - p2->x;
  double dy = p1->y - p2->y;
  return sqrt(dx * dx + dy * dy);
}