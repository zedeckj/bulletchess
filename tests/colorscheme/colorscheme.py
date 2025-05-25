import unittest
import sys
sys.path.append("./")
from bulletchess import *
import re

class TestColorSCheme(unittest.TestCase):

    def test_exists(self):
        with self.assertNoLogs():
            Board.ColorScheme



if __name__ == "__main__":
    unittest.main()
