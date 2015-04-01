import random
import math
from sklearn.cluster import KMeans
import os


NUM_CLUSTERS = 2
LOWEST_SAMPLE_POINT = 0 #element 0 of SAMPLES.
HIGHEST_SAMPLE_POINT = 3 #element 3 of SAMPLES.
BIG_NUMBER = math.pow(10, 10)

dataPoints = []
centroids = []


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


def initializeCentroids(dataSet):
    
    centroids.append(Centroid(dataSet[LOWEST_SAMPLE_POINT][0],dataSet[LOWEST_SAMPLE_POINT][1]))
    centroids.append(Centroid(dataSet[HIGHEST_SAMPLE_POINT][0],dataSet[HIGHEST_SAMPLE_POINT][1]))
    
    print("Centroids initialized at:")
    print("(%d,%d)" %(centroids[0].getX(), centroids[0].getY()) )
  #  print("({},{})", .format(centroids[1].getX(),centroids[1].getY()) )
    print("(%d,%d)" %(centroids[1].getX(), centroids[1].getY()) )
    print
    return

def initializeDataPoints(dataSet):
    
    for i in range(len(dataSet)):
        
        newPoint = DataPoint( dataSet[i][0], dataSet[i][1] )
        
        if(i == LOWEST_SAMPLE_POINT):
            newPoint.setCluster(0)
        elif(i == HIGHEST_SAMPLE_POINT):
            newPoint.setCluster(1)
        else:
            newPoint.setCluster(None)

        dataPoints.append(newPoint)    
    return

def getEuclideanDistance(x1, y1, x2, y2):
    return math.sqrt(math.pow(x2-x1,2) + math.pow(y2-y1,2))

def recalculateCentroids():
    totalX = 0
    totalY = 0
    totalInCluster = 0
    
    for j in range(NUM_CLUSTERS):    
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
        bestMinimum = BIG_NUMBER
        currentCluster = dataPoints[i].getCluster() 
        for j in range(NUM_CLUSTERS):
            curDistance = getEuclideanDistance(dataPoints[i].getX(),dataPoints[i].getY(),centroids[j].getX(),centroids[j].getY())
            if(curDistance < bestMinimum):
                bestMinimum = curDistance
                currentCluster = j 
                    
                
        dataPoints[i].setCluster(currentCluster)      
    
        if( (dataPoints[i].getCluster != currentCluster) ):
            dataPoints[i].setCluster(currentCluster)
            assignmentChanged = 1
    
    return assignmentChanged


def performKMeans(dataSet):
    
    DATASET_SIZE = len(dataSet)
    print("Size: %d" %DATASET_SIZE)
    
    assignmentChanged = 1
    print("Start initializing k-Means")
    
    initializeCentroids(dataSet)
    initializeDataPoints(dataSet)
    
    print("Start k-Means calculation")
    while(assignmentChanged):
        recalculateCentroids()
        assignmentChanged = updateClusters() 
    return


def printResults():
    for i in range(NUM_CLUSTERS):
        print("Cluster ", i, " includes:")
        for j in range(len(dataPoints)):
            if(dataPoints[j].getCluster() == i):
                print("(", dataPoints[j].getX(), ", ", dataPoints[j].getY(), ")")
        print()
    
    return

print os.__file__
kmeans = KMeans(4, random_state=8)
Y_hat = kmeans.fit(X).labels_
#dataSet = [[1.0,1.0], [1.5,2.0], [3.0,4.0], [5.0,7.0], [3.5,5.0], [4.5,5.0], [3.5,4.5]]
#performKMeans(dataSet)
#printResults()