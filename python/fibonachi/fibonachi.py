def fibonacci_generator(n):
    isSignChanged = False
    if (n < 0):
        isSignChanged = True
    n = abs(n)
    
    if (n == 0):
        yield 0
        return
    if (n == 1):
        yield  1
        yield  0
        return

    a = 0
    b = 1
    count = 1 
    n += 1
    yield a
    while count < n: 
        if (isSignChanged and (count % 2 == 0)):
            yield -b
        else:
            yield b
        tmp = b 
        b = a + b
        a = tmp
        count += 1


print(list(fibonacci_generator(10 )))
print(list(fibonacci_generator(-10)))




