import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestBoardHtml(unittest.TestCase):


    def test_html(self):
        html = Board()._repr_html_()
        print(html)

if __name__ == "__main__":
    unittest.main()
