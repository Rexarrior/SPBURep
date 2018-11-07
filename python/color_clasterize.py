import numpy as np 
import math as m
from PIL import Image, ImageDraw
import kmeans


def color_segmentation(imagePath, colors):
    img = Image.open(imagePath)
    pix = np.array(img)
    pix.transpose()
    new_pix = np.empty((pix.shape[0], pix.shape[1]))
    maxs = pix.max(axis=2)
    mins = pix.min
    for i in range(pix.shape[0]):
        for j in range(pix.shape[1]):
            p = pix[i][j]
            pM = np.max(p)
            pm = np.min(p)
            pd = pM - pm
            if (pm == pM):
                res = 0
            elif (pM == p[0]):
                res = 60 * (p[1] - p[2]) / pd
                if (p[1] < p[2]):
                    res += 360
            elif pM == p[1]:
                res = 60 * (p[2] - p[0])/pd + 120
            else:
                res = 60 * (p[0] - p[1])/pd + 240 
            new_pix[i][j] = res
    new_pix = np.reshape(new_pix.ravel(), (-1, 1))
    clasters = kmeans.kmeans(new_pix, len(colors), 1e-2)
    # clasters.sort()
    labels = kmeans.assign_clusters(new_pix, clasters)
    labels = np.reshape(labels, (pix.shape[0], pix.shape[1]))
    for i in range(len(colors)):
        pix[np.where(labels == i)] = np.array(colors[i])
    img = Image.fromarray(pix)
    img.save('img-processed.jpeg')

color_segmentation('img.jpeg', ((255, 0, 0), (0, 255, 0), (0, 0, 150),  (0, 150, 255)))