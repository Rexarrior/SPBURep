// 1.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
typedef  std::chrono::duration<double> duration_t;

#define STEP  1e-5
#define EPS  1e-4

#define PARALLEL
//#define PARALLEL_FOR
#define PARALLEL_REDUCTION

using namespace std;

duration_t count_run_duration(std::function<void()> func)
{
	auto start = std::chrono::system_clock::now();
	func();
	auto end = std::chrono::system_clock::now();
	std::chrono::duration<double> elapsed_seconds = end - start;
	return elapsed_seconds;
}


double get_rand(int min, int max)
{
	return (rand() % (max - min + 1) + min) + rand() / RAND_MAX;
}




double integral_func(double x)
{
	return	4.0 / (1 + x*x);
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



void first()
{
	cout << "First\n";
	auto start = std::chrono::system_clock::now();
	double res = count_integral(integral_func, 0, 1);
	auto end = std::chrono::system_clock::now();
	std::chrono::duration<double> elapsed_seconds = end - start;

	cout << "Result: " << res << '\n';
	cout << "Elapsed time: " << elapsed_seconds.count() << '\n';

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



void second()
{
	cout << "Second\n";
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


void third()
{
	cout << "Third\n";
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



int main()
{
	first();
	second();
	third();
	system("pause");
	return 0;
}

