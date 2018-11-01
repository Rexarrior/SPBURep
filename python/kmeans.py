import numpy as np


def calc_eps(X, k=0.01):
    min_dist = np.min(np.linalg.norm(X[0] - X[1:], axis=1))
    for i in range(1, X.shape[0] - 1):
        min_dist = min(min_dist, np.min(np.linalg.norm(
                                                       X[i] - X[i+1:],
                                                       axis=1)))
    return k*min_dist


def assign_clusters(X, clusters):
    """Assign a cluster label to each point in X

    Parameters
    ----------
    X : numpy.ndarray
        Matrix with X.shape[0] points with X.shape[1] coordinates
    clusters : numpy.ndarray
        The matrix of centers of the clusters with shape (k, X.shape[1]),
        where k is number of clusters

    Returns
    -------
    cluster_labels : numpy.ndarray
        Matrix of the cluster labels, shape (X.shape[1],).
        Each label is just index 0, 1, ... , k-1
    """
    cluster_labels = np.empty(X.shape[0], dtype=int)
    for i in range(X.shape[0]):
        cluster_labels[i] = (np.linalg.norm(X[i] - clusters, axis=1)).argmin()
    return cluster_labels


def update_clusters(X, cluster_labels):
    """Update centers of the clusters

    Parameters
    ----------
    X : numpy.ndarray
        Matrix with X.shape[0] points with X.shape[1] coordinates
    cluster_labels : numpy.ndarray
        Matrix of the cluster labels, shape (X.shape[0],).
        Each label is just index 0, 1, ... , k-1

    Returns
    -------
    updated_clusters : numpy.ndarray
        The matrix of centers of the clusters number
        of clusters with shape (k, X.shape[1])
    """
    k = (np.max(cluster_labels)) + 1
    updated_clusters = np.zeros((k, X.shape[1]))
    # counts = np.zeros(k)

    # for i in range(X.shape[0]):
    #     updated_clusters[cluster_labels[i]] += X[i]
    #     counts[cluster_labels[i]] += 1
    # updated_clusters /= counts[:, None]
    for i in range(k):
        points = X[np.where(cluster_labels == i)]
        updated_clusters[i] = np.sum(points, axis=0) / points.shape[0]
    return updated_clusters


def is_converged(clusters, updated_clusters, eps):
    """Check if algorithm is converged

    Parameters
    ----------
    clusters : numpy.ndarray
        The matrix of centers of the clusters with shape (k, X.shape[1])
    updated_clusters : numpy.ndarray
        The matrix of updated centers of
        the clusters with shape (k, X.shape[1])
    eps: float
        Сonvergence error
    Returns
    -------
    True if centers of each cluster are not modified with accuracy eps,
    else False
    """
    return np.max(np.linalg.norm(
                                 clusters - updated_clusters,
                                 axis=1
                                 )) < eps


def kmeans(X, k, eps=None):
    """K-means clustering algorithm.

    Parameters
    ----------
    X : numpy.ndarray
        Matrix with X.shape[0] points with X.shape[1] coordinates
    k : int
        The number of clusters.
    eps: float
        Сonvergence error.
        If None then calculated authomaticly as 0.01*min_dist,
        where min_dist is minimum distance between any two points from X

    Returns
    -------
    clusters : numpy.ndarray
        Matrix of the cluster centers, shape [k, X.shape[1]]
    """
    if not eps:
        eps = calc_eps(X)

    # random selection of k different initial points as clusters' centers
    clusters = X[np.random.choice(X.shape[0], k, replace=False), :]

    while True:
        cluster_labels = assign_clusters(X, clusters)
        updated_clusters = update_clusters(X, cluster_labels)
        if is_converged(clusters, updated_clusters, eps):
            break
        else:
            clusters = updated_clusters

    return updated_clusters

X = np.array([
    np.full(5, 2),
    np.full(5, 5),
    np.full(5, 8),
    np.full(5, 10),
    np.full(5, 4),
])

clasters = kmeans(X, 2)
print(clasters)
print(assign_clusters(X, clasters))
