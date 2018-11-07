from kmeans import *
import random as rnd

def improve_clast_by_disp(X, disp, matExpend, disp_eps, eps):
    currDisp = np.max(X - matExpend)
    if (abs(currDisp - disp) < disp_eps): # error
        return None
    if (len(X) <= 1):
        return X
    clasters = kmeans(X, 2, eps)
    labels = assign_clusters(X, clasters)
    new_clusters_list = []
    for i in range(clasters.shape[0]):
        ret = improve_clast_by_disp(X[np.where(labels == i)],
                                    currDisp, clasters[i],
                                    disp_eps, eps)
        if (ret is None):
            new_clusters_list.append(clasters[i].reshape(1, X.shape[1]))
        else:
            new_clusters_list.append(ret)
    new_clusters = np.concatenate(new_clusters_list)
    return new_clusters


def auto_kmeans(X, eps=None, startK=2, disp_eps=1):
    if (eps is None):
        calc_eps(X)
    matEpxend = np.average(X, axis=0)
    disp = np.max(X - matEpxend)
    return improve_clast_by_disp(X,  disp + 2 * disp_eps,
                                 matEpxend, disp_eps, eps)


X = np.empty((100, 5))
for i in range(25):
    X[i] = np.full(5, rnd.randint(0, 10))
for i in range(25, 50):
    X[i] = np.full(5, rnd.randint(50, 60))

for i in range(50, 75):
    X[i] = np.full(5, rnd.randint(80, 90))
for i in range(75, 100):
    X[i] = np.full(5, rnd.randint(0, 100))


clusters = auto_kmeans(X)
print(clusters)
print(assign_clusters(X, clusters))
