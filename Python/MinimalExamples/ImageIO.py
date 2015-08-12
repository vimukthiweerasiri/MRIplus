# The image I/O

import sys
sys.path.append('/usr/local/lib/python2.7/site-packages')
import cv2
import numpy as np

from matplotlib import pyplot as plt
#reading the image in grayscale
img = cv2.imread('../Images/Input/facebook_logo.jpg', 1)

# showing with default viewer
cv2.imshow('grayscale',img)
cv2.waitKey(0)
cv2.destroyAllWindows()

# showing with default matplot
plt.imshow(img, cmap = 'gray', interpolation = 'bicubic')
plt.xticks([]), plt.yticks([])  # to hide tick values on X and Y axis
plt.show()