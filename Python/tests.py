import unittest
import numpy as np
from dfs import get_predict_input


class Tiling(unittest.TestCase):
	def test_final_answer(self):
		test = np.array([[0, 0, 0, 0, 0, 1, 3], [0, 1, 2, 1, 4, 5, 5], [0, 0, 1, 1, 3, 4, 5], [1, 2, 3, 2, 2, 4, 4]])
		answer = np.array(
			[[-5.45454545, 9.09090909, -5.45454545, 1.81818182], [-1.81818182, -9.09090909, 5.45454545, 5.45454545]])
		test_result = get_predict_input(test)
		np.testing.assert_almost_equal(test_result, answer)

if __name__ == '__main__':
	unittest.main()
