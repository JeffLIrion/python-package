"""Unit tests for the python_package/simple.py module

"""


import sys
import unittest

sys.path.insert(0, '..')

from python_package import simple


class TestSimple(unittest.TestCase):
    def setUp(self):
        self.s = simple.Simple()

    def test_get_data(self):
        self.assertEqual(self.s.get_data(), 5)

    def test_set_data(self):
        self.s.set_data(6)
        self.assertEqual(self.s.get_data(), 6)


if __name__ == '__main__':
    unittest.main()
