import numpy as np 
import math as m
from PIL import Image, ImageDraw
import kmeans


def color_segmentation(imagePath, colors):
    img = Image.open(imagePath)
    pix = np.array(img)
    pix.transpose()
    new_pix = np.zeros((pix.shape[0], pix.shape[1]))
    pm = np.min(pix, axis=2)
    pM = np.max(pix, axis=2)

    ind_eq = (pm == pM)
    new_pix[ind_eq] = 0
    ind_neq = np.logical_not(ind_eq)
    ind = np.logical_and(pM == pix[:, :, 0], pix[:, :, 1] >= pix[:, :, 2])
    ind = np.logical_and(ind, ind_neq)  
    if (len(ind) > 0):
        curr_pM = pM[ind]
        curr_pm = pm[ind]
        curr_pix = pix[ind]
        new_pix[ind] = 60 * (curr_pix[:, 1] - curr_pix[:, 2]) / (curr_pM - curr_pm)
    
    ind = np.logical_and(pix[:, :, 1] < pix[:, :, 2], pix[:, :, 1] < pix[:, :, 2])
    ind = np.logical_and(ind, ind_neq)
    if (len(ind) > 0):
        new_pix[ind] += 360

    ind = pM == pix[:, :, 1] 
    ind = np.logical_and(ind, ind_neq)  
    if (len(ind) > 0):
        curr_pM = pM[ind]
        curr_pm = pm[ind]
        curr_pix = pix[ind]
        new_pix[ind] = 60 * (curr_pix[:, 2] - curr_pix[:, 0])/(curr_pM - curr_pm) + 120

    ind = pM == pix[:, :, 2]
    ind = np.logical_and(ind, ind_neq)  
    if (len(ind) > 0):
        curr_pM = pM[ind]
        curr_pm = pm[ind]
        curr_pix = pix[ind]
        new_pix[ind] = 60 * (curr_pix[:, 2] - curr_pix[:, 0])/(curr_pM - curr_pm) + 240

    new_pix = np.reshape(new_pix.ravel(), (-1, 1))
    clasters = kmeans.kmeans(new_pix, len(colors), 1)
    labels = kmeans.assign_clusters(new_pix, clasters)
    labels = np.reshape(labels, (pix.shape[0], pix.shape[1]))
    for i in range(len(colors)):
        pix[np.where(labels == i)] = np.array(colors[i])
    img = Image.fromarray(pix)
    img.save('img-processed.jpeg')

colors = []
for i in range(0, 256, 1):
    colors.append((i, i, i))
color_segmentation('img.jpeg', ((255, 0, 0), (0, 150, 255), (0, 0, 150),
                                (0, 255, 0)))