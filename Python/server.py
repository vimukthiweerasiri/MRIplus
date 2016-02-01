from flask import Flask, request
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

class Predict(Resource):
	def get(self, base64str):
		return base64str;

api.add_resource(Predict, '/<string:base64str>')

if __name__ == '__main__':
	app.run(debug=True)

