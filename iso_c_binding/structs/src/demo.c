#include <math.h>

typedef struct {
  double x;
  double y;
} PointT;

double dist_from_origin(PointT p) { return sqrt(p.x * p.x + p.y * p.y); }
