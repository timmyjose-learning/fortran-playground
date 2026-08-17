typedef int (*math_op)(int, int);

int apply(int a, int b, math_op op)
{
  return op(a, b);
}
