import numpy as np 
import math as m
from PIL import Image, ImageDraw

def GetKernel(n, sigma):
    kernel = np.array([[0 for i in range(n)] for j in range(n)], float)
   

    mean = n/2
    sum = 0.0 
    for x in range(n): 
        for y in range(n):
            kernel[x, y] = m.exp( -0.5 * (m.pow((x-mean)/sigma, 2.0) + m.pow((y-mean)/sigma,2.0)) ) /(2 * m.pi * sigma * sigma)

           
            sum += kernel[x, y]

  
    for x in range(n): 
        for y in range(n):
            kernel[x, y] /= sum
    return kernel




def UseKernel(pixMatrXY, kernel):
    res = [0, 0, 0]
    redarr = np.array([[pixMatrXY[i][j][0] for i in range(len(pixMatrXY[0]))] for j in range(len(pixMatrXY))], float)
    greenarr = np.array([[pixMatrXY[i][j][1] for i in range(len(pixMatrXY[0]))] for j in range(len(pixMatrXY))], float)
    bluearr = np.array([[pixMatrXY[i][j][2] for i in range(len(pixMatrXY[0]))] for j in range(len(pixMatrXY))], float)
    resred = redarr.dot(kernel)
    resblue = bluearr.dot(kernel)
    resgreen = greenarr.dot(kernel)
    
    
    res[0] = m.floor(resred.sum())
    res[1] = m.floor(resgreen.sum())
    res[2] = m.floor(resblue.sum())
    
    return res


def Filter(imageFileName, filterSize, sigma):
    
    if (filterSize % 2 == 0):
        filterSize += 1
    
    kernel = GetKernel(filterSize, sigma)
    image = Image.open(imageFileName)
    imageRes = Image.new('RGB', image.size)
    draw = ImageDraw.Draw(imageRes)
    pixs = image.load()


    for x in range(0, filterSize):
        for y in range(0, image.size[1]):
            draw.point((x,y), pixs[x,y])
    
    for x in range(0, image.size[0]):
        for y in range(0, filterSize):
            draw.point((x,y), pixs[x,y])
    
    for x in range(image.size[0] - filterSize - 1, image.size[0]):
        for y in range(0, image.size[1]):
            draw.point((x,y), pixs[x,y])
    
    for x in range(0, image.size[0]):
        for y in range(image.size[1] - filterSize - 1, image.size[1]):
            draw.point((x,y), pixs[x,y])
    


    for x in range(filterSize , image.size[0] - filterSize - 1):
        for y in range(filterSize , image.size[1] - filterSize - 1 ):
            m = int(filterSize // 2)
            matr = [[pixs[i, j] for i in range(x - m, x + m + 1, 1)] for j in range(y - m, y + m + 1, 1)]
            newpix = UseKernel(matr, kernel)
            draw.point((x,y), (newpix[0], newpix[1], newpix[2]))
    
    imageRes.save('result.jpg')

Filter('1.jpg', 5, 2)

    
