import numpy as np


def run_funcs_and_compress_value(funclist, args):
    results = np.zeros(len(funclist))
    for i in range(results.size):
        results[i] = funclist[i](args)
    return results


def wrap_func_list(funcList):
    return lambda X: run_funcs_and_compress_value(funcList, X)


if __name__ == '__main__':
    funclist = [
        lambda X: X[0] + X[1],
        lambda X: X[0] - X[1],
        lambda X: X[0] * X[1],
        lambda X: X[0] / X[1]
    ]
    wrappedFincList = wrap_func_list(funclist)
    x = [100, 10]
    print(wrappedFincList(x))
