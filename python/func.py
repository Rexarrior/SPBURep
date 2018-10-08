from mpmath import mp, mpf

def f(a,b):
    return (333.75 - a * a) * b ** 6 + a * a * (11 * a * a * b * b - 121 * b ** 4 - 2) + 5.5 * b ** 8 + a/(2.0*b)


def f_true(A, B):
    # TO DO:
    # вычисление значение функции с произвольной точностью и проверка результата на корректность с помощью 
    # интервального расчет при заданной точности
    verify_eps = mpf(1E-7)
    #eps = mpf(0.003906250000000000005)
    for j in range(6, 50):
        mp.dps = j
        a = mpf(A)
        b = mpf(B)
        ans = f(a, b)
        eps = (1.0/(10**(j-5)))
        ans_left_a = f(a - eps, b)
        ans_right_a = f(a + eps, b)
        ans_left_b = f(a, b - eps)
        ans_right_b = f(a, b + eps)
        if (abs(ans_left_a - ans_right_a) > verify_eps or 
            abs(ans_left_b - ans_right_b) > verify_eps or
            abs(ans_left_a - ans_right_b) > verify_eps or 
            abs(ans_left_b - ans_right_a) > verify_eps):
            continue
        
        return ans, j
    return 0



def testfunc(eps):
    return f_true(77617, 33096, eps) + 0.827




def half_divide_method(a, b, f):
    x = (a + b) / 2
    while abs(f(x)) >= 1e-1:
        x = (a + b) / 2
        a, b = (a, x) if f(a) * f(x) < 0 else (x, b)
    return (a + b) / 2






def show():
    A, B = 77617, 33096
    # TO DO:
    # вычисление значение функции с произвольной точностью и проверка результата на корректность с помощью 
    # интервального расчет при заданной точности
    verify_eps = mpf(1E-3)
    eps = mpf(1e-15)
    #eps = mpf(0.003906250000000000005)
    for j in range(6, 50):
        mp.dps = j
        a = mpf(A)
        b = mpf(B)
        ans = f(a, b)
        ans_left_a = f(a - eps, b)
        ans_right_a = f(a + eps, b)
        ans_left_b = f(a, b - eps)
        ans_right_b = f(a, b + eps)
        print(3*"\n")
        print(j )
        print(ans)
        print(abs(ans_left_a - ans_right_a))
        print(abs(ans_left_b - ans_right_b))
        print(abs(ans_left_a - ans_right_b))
        print(abs(ans_left_b - ans_right_a))
        

#show()
#half_divide_method(0.003906250000000000005,0.003906250005, testfunc )


print(f_true(77617, 33096))