#include "omp.h"
#include <cstdlib>
#include <cstdio>
#include "time.h"
#include  <chrono>
#include <iostream>

#define EPS  1e-4
// #define PARALLEL


using namespace std;



double get_rand(int min, int max)
{
	return (rand() % (max - min + 1) + min) + rand() / RAND_MAX;
}




void fill_by_rand(double* a, size_t n, int min, int max)
{
	for (size_t i = 0; i < n; i++)
	{
		a[i] = get_rand(min, max);
	}
}




bool check_scalar_product(double* a, double* b, size_t n,  double res)
{
	double new_res = 0;
	for (size_t i = 0; i < n; i++)
	{
		new_res += a[i] * b[i];
	}
	return abs(res - new_res) < EPS;
}


double scalar_product(double* a, double* b,  size_t n)
{
	double res = 0;
#ifdef PARALLEL
#pragma omp parallel for shared(a, b, n)
#endif // PARALLEL
	for (int i = 0; i < n; i++)
	{
		#pragma omp atomic
		res += a[i] * b[i];
	}
	return res;
}



int main()
{
    cout << "Mode: ";

#ifdef PARALLEL
    cout << "parallel\n";
#endif
#ifndef PARALLEL
    cout << "continuosly\n";
#endif

	size_t n = 1000000;
	int min = 0; 
	int max = 100; 
	double* a = new double[n];
	double* b = new double[n];
	fill_by_rand(a, n, min, max);
	fill_by_rand(b, n, min, max);
	auto start = std::chrono::system_clock::now();
	double res = scalar_product(a, b, n);
	auto end = std::chrono::system_clock::now();
	std::chrono::duration<double> elapsed_seconds = end - start;
	cout << "Result: " << check_scalar_product(a,b,n,res) << '\n';
	cout << "Elapsed time: " << elapsed_seconds.count() << '\n';
}