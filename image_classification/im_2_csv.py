import cv2 
import numpy as np

im = cv2.imread('uk_ire.png')
cv2.imwrite('uk_ire_gray.png', im_g)
im_g = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)

im_g_rot = np.rot90(np.rot90(np.rot90(im_g)))  # hack so that it opens correctly in R
np.savetxt("uk_ire_gray.csv",im_g_rot, delimiter=",", fmt='%3.0f')

