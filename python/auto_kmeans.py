from kmeans import *


def improve_clast_by_disp(X, disp, matExpend, disp_eps, eps):
    currDisp = np.max(X - matExpend)
    if (currDisp - disp < disp_eps): # error
        return None
    clasters = kmeans(X, 2)
    labels = assign_clusters(X, clasters)
    new_clusters_list = []
    for i in range(clasters.shape[0]):
        ret = improve_clast_by_disp(X[np.where(labels == labels[i])],
                                    currDisp, clasters[i],
                                    disp_eps, eps)
        if (ret is None):
            new_clusters_list.append(clusters[i].reshape(1, X.shape[1]))
        else:
            new_clusters_list.append(ret)
    new_clusters = np.concatenate(new_clusters_list)
    return new_clusters


def auto_kmeans(X, eps=None, startK=2, disp_eps=1e-5):
    if (eps is None):
        calc_eps(X)
    matEpxend = np.average(X, axis=0)
    disp = np.max(X - matEpxend)
    return improve_clast_by_disp(X,  disp + 2 * disp_eps,
                                 matEpxend, disp_eps, eps)

clusters = auto_kmeans(X)
print(clusters)
print(assign_clusters(X, clusters))
