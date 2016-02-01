import numpy as np

MAT = np.array([[0, 0, 0, 0, 0, 1, 3], [0, 1, 2, 0, 4, 5, 5], [0, 0, 1, 1, 3, 4, 5], [1, 2, 3, 0, 2, 4, 4]])
[numRow, numCol] = MAT.shape

print(MAT)


def mat2gray(matrix):
	min = np.min(matrix)
	max = np.max(matrix)
	return (matrix - min) / (max - min)


def normalize(matrix):
	var = np.var(matrix)
	mean = np.mean(matrix)
	return (matrix - mean) / var


def dfs(matrix, x, y):
	if x < 0 or y < 0 or numRow <= x or numCol <= y or matrix[x][y] == -1:
		return None
	if matrix[x][y] == 0:
		matrix[x][y] = -1
		dfs(matrix, x + 1, y)
		dfs(matrix, x, y + 1)
		dfs(matrix, x - 1, y)
		dfs(matrix, x + 1, y - 1)


MAT = mat2gray(MAT)

for x in range(numRow):
	dfs(MAT, x, 0)
	dfs(MAT, x, numCol - 1)

for y in range(numCol):
	dfs(MAT, 0, y)
	dfs(MAT, numRow - 1, y)

print()
print(MAT)

data = []
# send this to configuration the 16
tile_size = 2
for x in range(0, numRow - tile_size + 1, tile_size):
	for y in range(0, numCol - tile_size + 1, tile_size):
		print(x, y)
		temp = MAT[x:x + tile_size, y:y + tile_size]
		normalize(temp)
		if -1 not in temp:
			data.append(normalize(temp.transpose().flatten()))

print(np.array(data))
