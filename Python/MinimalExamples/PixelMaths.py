# Basic Image 

import sys
sys.path.append('/usr/local/lib/python2.7/site-packages')
import cv2
import numpy as np

from matplotlib import pyplot as plt

img = cv2.imread('../Images/Input/facebook_logo.jpg', 1)
print img.shape

#reading the image in grayscale
img = cv2.imread('../Images/Input/facebook_logo.jpg', 0)
print img.shape