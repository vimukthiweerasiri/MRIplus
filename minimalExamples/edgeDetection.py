# This uses the canny edge detection algorith explained in the below link
# http://opencv-python-tutroals.readthedocs.org/en/latest/py_tutorials/py_imgproc/py_canny/py_canny.html

import sys
sys.path.append('/usr/local/lib/python2.7/site-packages')
import cv2
import numpy as np

from matplotlib import pyplot as plt

img = cv2.imread('../Images/Input/facebook_logo.jpg',0)

edges = cv2.Canny(img,100,200)

plt.subplot(121),plt.imshow(img,cmap = 'gray')
plt.title('Original Image'), plt.xticks([]), plt.yticks([])
plt.subplot(122),plt.imshow(edges,cmap = 'gray')
plt.title('Edge Image'), plt.xticks([]), plt.yticks([])

plt.show()