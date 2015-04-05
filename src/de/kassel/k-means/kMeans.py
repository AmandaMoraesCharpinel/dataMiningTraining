import random
import sys
from random import randint
import math
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.cm as cm

K = 2 
MIN_RAND_VALUE = 0
MAX_RAND_VALUE = 100

dataPoints = []
centroids = []
MAX_ITERATION = 50000
NUM_DATA_VALUES = 7


class DataPoint:
    def __init__(self,x,y):
        self.x = x
        self.y = y
        
    def setX(self,x):
        self.x = x
        
    def setY(self,y):
        self.y = y 
    
    def getX(self):
        return self.x
    
    def getY(self):
        return self.y
    
    def setCluster(self,clusterNumber):
        self.clusterNumber = clusterNumber
        
    def getCluster(self):
        return self.clusterNumber
    
class Centroid:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def setX(self, x):
        self.x = x 
        
    def getX(self):
        return self.x
    
    def setY(self,y):
        self.y = y 
    
    def getY(self):
        return self.y


def initializeCentroids():
    
    centroids.append(Centroid(2,2))
    centroids.append(Centroid(4,4))    
    #for i in range (K):	
    	#centroids.append(Centroid(random.uniform(MIN_RAND_VALUE,MAX_RAND_VALUE),  random.uniform(MIN_RAND_VALUE,MAX_RAND_VALUE)))
    #return

def initializeDataPoints():
    bla = [[1.0, 1.0], [1.5, 2.0], [3.0, 4.0], [5.0, 7.0], [3.5, 5.0], [4.5, 5.0], [3.5, 4.5]]
    for i in range(NUM_DATA_VALUES):
        #newPoint = DataPoint( random.uniform(MIN_RAND_VALUE,MAX_RAND_VALUE), random.uniform(MIN_RAND_VALUE,MAX_RAND_VALUE) )
        newPoint = DataPoint( bla[i][0],bla[i][1])
        newPoint.setCluster( random.randint(0,K-1) ) 
        dataPoints.append(newPoint)    
    
    return

def getEuclideanDistance(x1, y1, x2, y2):
    return math.sqrt(math.pow(x2-x1,2) + math.pow(y2-y1,2))

def recalculateCentroids():
    totalX = 0
    totalY = 0
    totalInCluster = 0
    
    for j in range(K):    
        for k in range(len(dataPoints)):
            if (dataPoints[k].getCluster() == j ):
                totalX += dataPoints[k].getX()
                totalY += dataPoints[k].getY()
                totalInCluster += 1
                
        if(totalInCluster > 0):
            centroids[j].setX(totalX / totalInCluster)
            centroids[j].setY(totalY / totalInCluster)
    
    return

def updateClusters():
    assignmentChanged = 0
    
    for i in range(len(dataPoints)):
        bestMinimum = sys.float_info.max
        currentCluster = dataPoints[i].getCluster() 
        for j in range(K):
            curDistance = getEuclideanDistance(dataPoints[i].getX(),dataPoints[i].getY(),centroids[j].getX(),centroids[j].getY())
            if(curDistance < bestMinimum):
                bestMinimum = curDistance
                currentCluster = j 
    
        if( (dataPoints[i].getCluster != currentCluster) ):
            dataPoints[i].setCluster(currentCluster)
            assignmentChanged = 1
    
    return assignmentChanged


def performKMeans():
    
    assignmentChanged = 1
    print("Start initializing k-Means")
    
    initializeCentroids()
    initializeDataPoints()
    
    print("Start k-Means calculation")
    i = 0
    while(assignmentChanged and i < MAX_ITERATION  ):
        assignmentChanged = updateClusters()
	recalculateCentroids() 
	print("assigmentChanged %d:"  %assignmentChanged)
	i = i + 1	
    return


def printResults():
    print("Cluster")
    x = np.arange(10)
    ys = [i+x+(i*x)**2 for i in range(10)]
    colors = iter(cm.rainbow(np.linspace(0, 1, len(ys))))
    for i in range(K):
        print("Cluster ", i, " includes:")
	X = []
	Y = []
        for j in range(len(dataPoints)):
            if(dataPoints[j].getCluster() == i):
                print("(", dataPoints[j].getX(), ", ", dataPoints[j].getY(), ")")
		X.append( dataPoints[j].getX())
		Y.append( dataPoints[j].getY())
        print()
        nextColor = next(colors)
    	plt.scatter(X,Y,color=nextColor)
        plt.scatter(centroids[i].getX(),centroids[i].getY(),marker=">",color=nextColor, s = 50)
    plt.show()   
    return
print("start")
performKMeans()
print("end")
printResults()
print("end print")
