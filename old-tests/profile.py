import unittest
import sys
sys.path.append("./")
from bulletchess import *
from testing_utils import random_board
import time
import random

class ProflingTest(unittest.TestCase):

    def testApplyVsGen(self):
      COUNT = 10000
      boards = [random_board() for _ in range(COUNT)]
      gen_time = time.time()
      for board in boards:
        board.legal_moves()
      gen_time = time.time() - gen_time
      moves = []
      for board in boards:
        moves.append(random.choice(board.legal_moves()))
      time.sleep(2)
      apply_time = time.time()
      for i in range(COUNT):
        boards[i].apply(moves[i])
      apply_time = time.time() - apply_time
      time.sleep(2)
      check_time = time.time()
      for board in boards:
          board.in_check()
      check_time = time.time() - check_time
      print(apply_time, gen_time, check_time)
      self.assertLess(apply_time,gen_time)
      

if __name__ == "__main__":
    unittest.main()
        
