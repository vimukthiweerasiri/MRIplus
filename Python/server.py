from flask import Flask, request
from flask_restful import Resource, Api
import numpy as np
from dfs import get_predict_input
import dicom
import base64

app = Flask(__name__)
api = Api(app)


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


api.add_resource(Predict, '/<string:base64str>')

if __name__ == '__main__':
	app.run(debug=True)
