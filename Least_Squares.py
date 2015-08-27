"""Linear Regression fits a linear model with coefficients w = (w_1, ...., w_p)
to minimize the residual sum of squres between the observed responses in the
dataset, and the responsees predicted by the linear approximation. In other words
we want to find a line that best fits the data (Best Fitting Line). The corresponding matrix equation of
this is Ax = b. Not every Least Squares problem will have an exact solution, however,
we have x = (((A^T)*A)^-1)*(A^T)*b where the * = matrix multiplication."""


#Example:

from sklearn import linear_model

#Create an classifier object called clf (an instance of linear_model.LinearRegression())
clf = linear_model.LinearRegression()

#Call the method fit(X,y) to create a best fit line between the method arrays X and y and will store the coefficients of the line in the coef_ member.
clf.fit([[0,0],[1,1],[2,2]], [0,1,2])

print(clf.coef_)


