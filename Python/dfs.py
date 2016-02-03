import numpy as np
from sklearn import svm, cross_validation, metrics
import pickle
import base64
import matplotlib.pyplot as plt
import matplotlib.cm as cm


def mat2gray(matrix):
	min = np.min(matrix)
	max = np.max(matrix)
	return (matrix - min) if (max - min) == 0 else (matrix - min) / (max - min)


def normalize(matrix):
	std = np.var(matrix)
	mean = np.mean(matrix)
	return (matrix - mean) if std == 0 else (matrix - mean) / std


def dfs(matrix, x, y, numRow, numCol):
	if x < 0 or y < 0 or numRow <= x or numCol <= y or matrix[x][y] == -1:
		return None
	if matrix[x][y] == 0:
		matrix[x][y] = -1
		dfs(matrix, x + 1, y, numRow, numCol)
		dfs(matrix, x, y + 1, numRow, numCol)
		dfs(matrix, x - 1, y, numRow, numCol)
		dfs(matrix, x + 1, y - 1, numRow, numCol)


def dfs_iterative(matrix, idx, idy):
	if matrix[idx][idy] != 0:
		return None
	[numRow, numCol] = matrix.shape
	stack = [idx * numCol + idy]

	while len(stack) != 0:
		val = stack.pop()
		x = int(val / numCol)
		y = val % numCol
		matrix[x][y] = -1

		if x > 0 and matrix[x - 1][y] == 0:
			stack.append((x - 1) * numCol + y)
		if y > 0 and matrix[x][y - 1] == 0:
			stack.append(x * numCol + (y - 1))
		if numRow - 1 > x and matrix[x + 1][y] == 0:
			stack.append((x + 1) * numCol + y)
		if numCol - 1 > y and matrix[x][y + 1] == 0:
			stack.append(x * numCol + (y + 1))


def get_predict_input(MAT, tile_size):
	# MAT = mat2gray(MAT)
	# print(MAT)
	RESULT = np.copy(MAT)
	ORIGINAL = np.copy(MAT)
	[numRow, numCol] = MAT.shape
	for x in range(numRow):
		dfs_iterative(MAT, x, 0)
		dfs_iterative(MAT, x, numCol - 1)

	for y in range(numCol):
		dfs_iterative(MAT, 0, y)
		dfs_iterative(MAT, numRow - 1, y)

	data = []
	newModel = None
	with open('model.pkl', 'rb') as input:
		newModel = pickle.load(input)

	# send this to configuration the 16
	for x in range(0, numRow - tile_size + 1, tile_size):
		for y in range(0, numCol - tile_size + 1, tile_size):
			temp = MAT[x:x + tile_size, y:y + tile_size]
			if -1 not in temp:
				result = (newModel.predict([normalize(temp.transpose().flatten())]))[0]
				(RESULT[x:x + tile_size, y:y + tile_size]).fill(result * 256)
				print(result)
				data.append(normalize(temp.transpose().flatten()))

	plt.imshow(ORIGINAL, cmap=cm.Greys_r)
	plt.savefig('ORIGINAL.png')
	original_base64 = base64.b64encode(open("ORIGINAL.png", "rb").read()).decode("utf-8")
	plt.imshow(RESULT, cmap=cm.Greys_r)
	plt.savefig('RESULT.png')
	result_base64 = base64.b64encode(open("RESULT.png", "rb").read()).decode("utf-8")
	print(original_base64)
	print(result_base64)
	print(type(original_base64))
	print(type(result_base64))

	return [original_base64, result_base64]
