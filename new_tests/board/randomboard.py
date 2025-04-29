import unittest
import sys
sys.path.append("./")
from bulletchess import *

class TestBoardRandom(unittest.TestCase):

    def test_basic(self):
        COUNT = 1000
        boards = [Board.random() for _ in range(COUNT)]
        not_equals = 0
        for i in range(COUNT):
            equal = False
            for j in range(i + 1, COUNT):
                if boards[i] == boards[j]:
                    equal = True
                    break
            if not equal:
                not_equals += 1
        # comes out to be all unique every time ive run, this is just a bare minimum threshold
        # testing randomness is hard
        self.assertGreater(not_equals, 995)
        
if __name__ == "__main__":
    unittest.main()
