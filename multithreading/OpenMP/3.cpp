#include "omp.h"
#include <cstdlib>
#include <cstdio>
#include "time.h"
#include  <chrono>
#include <iostream>
#define PARALLEL

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



void print_matr(double* matr, size_t n, size_t m)
{
	for (size_t i = 0; i < m; i++ )
	{
		for (size_t j = 0; j < n; j++)
			cout << matr[i*n + j] << "   ";
		cout << "\n";
	}
}




double get_max_min(double* matr, size_t n, size_t m)
{
	double max;
#ifdef  PARALLEL
#pragma omp parallel for shared(matr, n, m)
#endif //  PARALLEL
	for (int i = 0; i < m; i++)
	{
		double min = matr[n*i];
		for (size_t j = 1; j < n; j++)
		{
			size_t ind = n * i + j;
			if (matr[ind] < min)
				min = matr[ind];
		}
#pragma omp critical
		if (min > max)
			max = min;
	}
	return max;
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


    size_t n = 5000;    
	size_t m = 5000; 
	size_t matr_size = n * m;
	double* matr = new double[matr_size];
	fill_by_rand(matr, matr_size, 0, 10);
	auto start = std::chrono::system_clock::now();
	double res = get_max_min(matr, n, m);
	auto end = std::chrono::system_clock::now();
	std::chrono::duration<double> elapsed_seconds = end - start;
	//cout << "Matrix:\n";
	//print_matr(matr, n, m);
	//cout << "Result: " << res << '\n';
	cout << "Elapsed time: " << elapsed_seconds.count() << '\n';
}