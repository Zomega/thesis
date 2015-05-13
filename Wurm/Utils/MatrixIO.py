import csv
import numpy

def load(f_name):
	with open(f_name, "rb") as f:
		reader=csv.reader(f, delimiter=',', quotechar='"')
		x=list(reader)
		return numpy.array(x).astype('float')

def store(f_name, matrix):
	numpy.savetxt(f_name, matrix, delimiter=",")
