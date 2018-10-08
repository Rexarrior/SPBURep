import numpy as np
import pylab
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt


def f(t, x, g=9.8, l=1):
  theta, ang_vel  = x[0], x[1]
  return np.array([ang_vel, -g*np.sin(theta)/l])




def get_k1(F, t, x, dt ):
    return F(t,x) * dt



def get_k2(F, t, x, dt, k1):
    return F(t + dt / 2, x + k1 / 2 ) * dt


def get_k3(F, t, x, dt, k2):
    return F(t + dt / 2, x + k2 / 2) * dt

def get_k4(F, t, x, dt, k3):
    return F(t + dt, x + k3) * dt


def get_next_x(F, t, x, dt):
    k1 = get_k1(F, t, x, dt)
    k2 = get_k2(F, t, x, dt, k1)
    k3 = get_k3(F, t, x, dt, k2)
    k4 = get_k4(F, t, x, dt, k3)
    return x + (1.0 / 6) * (k1 + 2 * k2 + 2 * k3 + k4)



def rk4(F, t0, x0, t, dt=0.1):
    
    arg_size = x0.size

    ts = np.arange(t0, t + dt, dt)
    ts[-1] = t
    
    xs = np.zeros((ts.size, arg_size), dtype = float)
    xs[0] = x0
    for i in range(1, ts.size - 1 ):
        xs[i] = get_next_x(F, ts[i-1], xs[i-1], dt)

    xs[-1] = get_next_x(F, ts[-1], xs[-2],  ts[-1] - ts[-2])
    return xs, ts 



def plot3d( x):
    fig = pylab.figure()
    axes = Axes3D(fig)
    t = x[1]
    x = x[0]
    x0 = np.array([x[i][0] for i in range(len(x)) ])
    x1 = np.array([x[i][1] for i in range(len(x)) ])

    axes.plot(t,x0,x1)



def plot2d( x):
    t = x[1]
    x = x[0]
    fig = plt.figure()
    x0 = np.array([x[i][0] for i in range(len(x)) ])
    plt.plot(t, x0)

def plot2d_front( x):
    t = x[1]
    x = x[0]
    fig = plt.figure()
    x0 = np.array([x[i][0] for i in range(len(x)) ])
    x1 = np.array([x[i][1] for i in range(len(x)) ])
    plt.plot(x0, x1)


x1 = rk4(f, 0,  np.array([np.pi/4, 0]), 100, dt=0.1)
x2 = rk4(f, 0,  np.array([np.pi/4, 0]), 100, dt=0.37)
x3 = rk4(f, 0,  np.array([np.pi/4, 0]), 100, dt=1)
x4 = rk4(f, 0,  np.array([np.pi/4, 0]), 100, dt=10)

# plot solutions...




#t1 = np.arange(0, 100 + 0.1, 0.1)
#t2 = np.arange(0, 100 + 0.37, 0.37)
#t3 = np.arange(0, 100 + 1, 1)
#t4 = np.arange(0, 100 + 10, 10)


plot3d(x1)
plot3d(x2)
plot3d(x3)
plot3d(x4)


#too many plots...
'''
plot2d(x1)
plot2d(x2)
plot2d(x3)
plot2d(x4)
'''
pylab.show()

