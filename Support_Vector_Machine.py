import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn import svm

digits = datasets.load_digits()

clf = svm.SVC(gamma=0.001, C=100)

#Store all the digits data all the way up to the last digits data as well as there targets (labels)
x,y = digits.data[:-20], digits.target[:-20]

#Make a best fit line that distinguishes and classifies the different types of data
clf.fit(x,y)

#Predict the desired elements that the computer has not seen yet.
print('Prediction:',clf.predict(digits.data[-20]))

#Let's look at a graphical image of what the -20th element of the dataset actually is so we can see if the computer got it right.
plt.imshow(digits.images[-20], cmap=plt.cm.gray_r, interpolation="nearest")
plt.show()
