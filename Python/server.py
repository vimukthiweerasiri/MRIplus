from flask import Flask, request
from flask_restful import Resource, Api
import numpy as np
from dfs import get_predict_input
import dicom
import base64
from PIL import Image
from dfs import dfs_iterative, normalize
from numpy import genfromtxt

app = Flask(__name__)
api = Api(app)

def retrain(im1, im2):
	fp1 = open('im1.png', 'wb')
	fp1.write(base64.b64decode(im1))
	fp1.close()
	fp2 = open('im2.png', 'wb')
	fp2.write(base64.b64decode(im2))
	fp2.close()
	img1 = Image.open('im1.png')
	img1.load()
	data1 = np.asarray( img1, dtype="int32")

	img2 = Image.open('im2.png')
	img2.load()
	data2 = np.asarray( img2, dtype="int32")
	data1 = np.array(data1)
	data2 = np.array(data1)


	RESULT = np.copy(data2)
	ORIGINAL = np.copy(data1)
	[numRow, numCol] = RESULT.shape
	for x in range(numRow):
		dfs_iterative(RESULT, x, 0)
		dfs_iterative(RESULT, x, numCol - 1)

	for y in range(numCol):
		dfs_iterative(RESULT, 0, y)
		dfs_iterative(RESULT, numRow - 1, y)

	train = []
	target = []

	tile_size = 16
	# send this to configuration the 16
	for x in range(0, numRow - tile_size + 1, tile_size):
		for y in range(0, numCol - tile_size + 1, tile_size):
			temp = RESULT[x:x + tile_size, y:y + tile_size]
			if -1 not in temp:
				train.append((normalize(ORIGINAL[x:x + tile_size, y:y + tile_size])).transpose().flatten())
				if 0 in temp and 1 in temp:
					target.append(1)
				else:
					target.append(0)
	print(np.array(train).shape)
	print(np.array(target).shape)
	np.savetxt("fooI.csv", np.array(train), delimiter=",")
	np.savetxt("fooO.csv", np.array(target), delimiter=",")



def get_results(base64str):
	# should avoid this file writing with a mimic, see later
	fp = open('test2.dcm', 'wb')
	fp.write(base64.b64decode(base64str))
	fp.close()

	plan = dicom.read_file('test2.dcm')
	print(plan)
	data = np.array(plan.pixel_array)
	data = data.astype(int)
	print(data.shape)
	return get_predict_input(data, 16)

class Predict(Resource):
	def get(self, base64str):
		newstr = base64str.replace("-", '/')
		result = get_results(newstr)
		# return {'original': 'vimukthi', 'result': 'weerasiri'}
		return {'original': result[0], 'result': result[1]}

class ImData(Resource):
	def get(self, base64str1, base64str2):
		print('came')
		im1 = base64str1.replace("-", '/')
		im2 = base64str2.replace("-", '/')
		print(im1, im2)
		retrain(im1, im2)


api.add_resource(Predict, '/<string:base64str>')
api.add_resource(ImData, '/data/<string:base64str1>/<string:base64str2>')

if __name__ == '__main__':
	app.run(debug=True)
