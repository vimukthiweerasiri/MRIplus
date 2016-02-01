from sklearn import svm, cross_validation, metrics
import numpy as np
import pickle

X = np.loadtxt(open("INPUT.csv", "rb"), delimiter=",")
Y = np.loadtxt(open("TARGET.csv", "rb"), delimiter=",")
X_train, X_test, Y_train, Y_test = cross_validation.train_test_split(X, Y, test_size=0.1, random_state=18)
print(len(X_train))
print(len(X_test))
max_accuracy = 0


def measure(x_train, y_train, x_test, y_test):
	clf = svm.SVC(C=C, kernel='rbf', gamma=gamma / 10.0)
	clf.fit(x_train, y_train)

	with open('model.pkl', 'wb') as output:
		pickle.dump(clf, output, pickle.HIGHEST_PROTOCOL)

	newModel = None
	with open('model.pkl', 'rb') as input:
		newModel = pickle.load(input)
	print(type(newModel))
	cm = metrics.confusion_matrix(newModel.predict(x_test), y_test)
	return ((cm[0][0] + cm[1][1]) * 100.0) / (cm[0][0] + cm[1][0] + cm[0][1] + cm[1][1])


for C in range(1, 2):
	for gamma in range(20, 21):
		answer = measure(X_train, Y_train, X_test, Y_test)
		if max_accuracy < answer:
			max_accuracy = answer

		print("C: ", C, "gamma: ", gamma, "accuracy: ", answer, "current max: ", max_accuracy)
print(max_accuracy)
