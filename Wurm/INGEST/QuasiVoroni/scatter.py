#!/usr/bin/env python

import click

import numpy as np
import matplotlib.pyplot as plt

from numpy import genfromtxt
#my_data = genfromtxt('my_file.csv', delimiter=',')

@click.command()
def drawscatter()
    N = 10**5
    x = list( np.random.rand(N) ) 
    y = list( np.random.rand(N) )
    colors = [ int(10 * v) for v in list( np.random.rand(N) ) ]
    print len(x), len(y), len(colors)
    area = np.pi * (15 * np.random.rand(N))**2 # 0 to 15 point radiuses
    plt.scatter(x, y, c=colors, edgecolors='none')
    plt.show()
    
if __name__ == '__main__':
    drawscatter()
