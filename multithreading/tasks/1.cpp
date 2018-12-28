#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#define PI 3.1415926536


double F(double x)
{
  return 1.0 / (1 + x*x);
}


int main() {
  
  double step, t;
  double a  = 0; 
  double b = 1; 
  double factor = 4; 
  int n = 10000; 
  system("chcp 1251");
  system("cls");

  printf("Количество точек = %d\n", n);
  step = (b - a) / n; // величина шага (высота трапеций)
  printf("Величина шага = %lf\n", step);
  int tmp = clock();
  double res = 0; 

  // # pragma omp parallel for reduction(+: res) num_threads(4)
  for (int i = 0; i < n; i ++)
  {
    //#pragma omp atomic
    res += F(a + i * step);
  }
  res *= step;
  res *= factor;  
  tmp = clock() - t; 
  printf("Значение интеграла = %lf\n", res);
  printf("Значение Пи = %lf\n", PI);
  printf("Разница: %lf\n", PI - res);
  printf("Время исполнения: %d\n", tmp);
  getchar();
  return 0;
}