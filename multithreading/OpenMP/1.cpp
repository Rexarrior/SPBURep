#include "omp.h"
#include <cstdlib>
#include <cstdio>
#include "time.h"
#include  <chrono>
#include <iostream>

#define STEP  1e-5
//#define PARALLEL_FOR
// #define PARALLEL_REDUCTION


using namespace std;


double count_integral(double f(double), double a, double b)
{
	double summ = 0;
	size_t n = (b - a) / STEP;
#ifdef PARALLEL_FOR
#pragma omp parallel for 
#endif
#ifdef PARALLEL_REDUCTION
#pragma omp parallel for shared(f, a, b, n)  reduction(+: summ)
#endif
	for (int i = 0; i <= n; i++)
	{
		double curr = a + STEP * i;
		summ += f(curr);
	}
	summ *= STEP; 
	return summ;
}




double integral_func(double x)
{
	return	4.0 / (1 + x*x);
}




int main()
{
	auto start = std::chrono::system_clock::now();
	double res = count_integral(integral_func, 0, 1);
	auto end = std::chrono::system_clock::now();
	std::chrono::duration<double> elapsed_seconds = end - start;
    cout << "Mode: ";

#ifdef PARALLEL_FOR
    cout << "parallel for\n";
#endif
#ifdef PARALLEL_REDUCTION
    cout << "parallel reduction\n";
#endif

#ifndef PARALLEL_FOR
#ifndef PARALLEL_REDUCTION
    cout << "continuosly\n";
#endif
#endif

	cout << "Result: " << res << '\n';
	cout << "Elapsed time: " << elapsed_seconds.count() << '\n';

}