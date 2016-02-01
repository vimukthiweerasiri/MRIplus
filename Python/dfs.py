import numpy as np


def mat2gray(matrix):
	min = np.min(matrix)
	max = np.max(matrix)
	return (matrix - min) / (max - min)


def normalize(matrix):
	var = np.var(matrix)
	mean = np.mean(matrix)
	return (matrix - mean) / var


def dfs(matrix, x, y, numRow, numCol):
	if x < 0 or y < 0 or numRow <= x or numCol <= y or matrix[x][y] == -1:
		return None
	if matrix[x][y] == 0:
		matrix[x][y] = -1
		dfs(matrix, x + 1, y, numRow, numCol)
		dfs(matrix, x, y + 1, numRow, numCol)
		dfs(matrix, x - 1, y, numRow, numCol)
		dfs(matrix, x + 1, y - 1, numRow, numCol)


def get_predict_input(MAT):
	MAT = mat2gray(MAT)
	[numRow, numCol] = MAT.shape
	for x in range(numRow):
		dfs(MAT, x, 0, numRow, numCol)
		dfs(MAT, x, numCol - 1, numRow, numCol)

	for y in range(numCol):
		dfs(MAT, 0, y, numRow, numCol)
		dfs(MAT, numRow - 1, y, numRow, numCol)

	data = []

	# send this to configuration the 16
	tile_size = 2
	for x in range(0, numRow - tile_size + 1, tile_size):
		for y in range(0, numCol - tile_size + 1, tile_size):
			temp = MAT[x:x + tile_size, y:y + tile_size]
			normalize(temp)
			if -1 not in temp:
				data.append(normalize(temp.transpose().flatten()))

	return np.array(data)