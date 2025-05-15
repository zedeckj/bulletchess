import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestColorSCheme(unittest.TestCase):

    def test_basic(self):
        cs = ColorScheme(10,20,40)
        self.assertEqual(cs.light_square_color, 10)
        self.assertEqual(cs.dark_square_color, 20)
        self.assertEqual(cs.highlight_color, 40)



if __name__ == "__main__":
    print(Board().pretty(cs, ))
    unittest.main()
