import sys
sys.path.append("./")
import unittest
import random
import time
from bulletchess import *
from bulletchess.utils import count_moves
import cProfile

def native_perft(board : Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return count_moves(board)
    else:
        moves = board.legal_moves()
        nodes = 0
        for move in moves:
            board.apply(move)
            nodes += native_perft(board, depth -1)
            board.undo()
        return nodes 

class TestPerft(unittest.TestCase):


    # Positions taken from https://www.chessprogramming.org/Perft_Results

    def test_native(self):
        board = Board()
        self.assertEqual(native_perft(board,0), 1)
        self.assertEqual(native_perft(board,1), 20)
        self.assertEqual(native_perft(board,2), 400)
        self.assertEqual(native_perft(board,3), 8902)
        self.assertEqual(native_perft(board,4), 197281)
        self.assertEqual(native_perft(board,5), 4865609)


    def test_native_pos2(self):
        board= Board.from_fen("r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1")
        self.assertEqual(native_perft(board,1), 48)
        self.assertEqual(native_perft(board,2), 2039)
        self.assertEqual(native_perft(board,3), 97862)
        self.assertEqual(native_perft(board,4), 4085603)
        self.assertEqual(native_perft(board,5), 193690690)

    def test_native_pos3(self):
        board = Board.from_fen("8/2p5/3p4/KP5r/1R3p1k/8/4P1P1/8 w - - 0 1")
        self.assertEqual(native_perft(board,1), 14)
        self.assertEqual(native_perft(board,2), 191)
        self.assertEqual(native_perft(board,3), 2812)
    
    def test_native_pos4(self):
        board = Board.from_fen("r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1")
        self.assertEqual(native_perft(board,1), 6)
        self.assertEqual(native_perft(board,2), 264)
        self.assertEqual(native_perft(board,3), 9467)
        self.assertEqual(native_perft(board,4), 422333)

    def test_native_pos5(self):
        board = Board.from_fen("rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPP1NnPP/RNBQK2R w KQ - 1 8  ")
        self.assertEqual(native_perft(board,1), 44)
        self.assertEqual(native_perft(board,2), 1486)
        self.assertEqual(native_perft(board,3), 62379)

    def test_native_pos6(self):
        board = Board.from_fen("r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10 ")
        self.assertEqual(native_perft(board,1), 46)
        self.assertEqual(native_perft(board,2), 2079)
        self.assertEqual(native_perft(board,3), 89890)
        self.assertEqual(native_perft(board,4), 3894594)



    def test_perft(self):
        board = Board()
        
        self.assertEqual(utils.perft(board,0), 1)
        self.assertEqual(utils.perft(board,1), 20)
        self.assertEqual(utils.perft(board,2), 400)
        self.assertEqual(utils.perft(board,3), 8902)
        self.assertEqual(utils.perft(board,4), 197281)
        self.assertEqual(utils.perft(board,5), 4865609)
        #self.assertEqual(utils.perft(board,6), 119060324)
        #self.assertEqual(utils.perft(board,7), 3195901860)

        
    def test_pos2(self):
        board= Board.from_fen("r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1")
        self.assertEqual(utils.perft(board,1), 48)
        self.assertEqual(utils.perft(board,2), 2039)
        self.assertEqual(utils.perft(board,3), 97862)
        self.assertEqual(utils.perft(board,4), 4085603)
        self.assertEqual(utils.perft(board,5), 193690690)
        #self.assertEqual(utils.perft(board,6), 8031647685)

    def test_pos3(self):
        board = Board.from_fen("8/2p5/3p4/KP5r/1R3p1k/8/4P1P1/8 w - - 0 1")
        self.assertEqual(utils.perft(board,1), 14)
        self.assertEqual(utils.perft(board,2), 191)
        self.assertEqual(utils.perft(board,3), 2812)
    
    def test_pos4(self):
        board = Board.from_fen("r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1")
        self.assertEqual(utils.perft(board,1), 6)
        self.assertEqual(utils.perft(board,2), 264)
        self.assertEqual(utils.perft(board,3), 9467)
        self.assertEqual(utils.perft(board,4), 422333)

    def test_pos5(self):
        board = Board.from_fen("rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPP1NnPP/RNBQK2R w KQ - 1 8  ")
        self.assertEqual(utils.perft(board,1), 44)
        self.assertEqual(utils.perft(board,2), 1486)
        self.assertEqual(utils.perft(board,3), 62379)

    def test_pos6(self):
        board = Board.from_fen("r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10 ")
        self.assertEqual(utils.perft(board,1), 46)
        self.assertEqual(utils.perft(board,2), 2079)
        self.assertEqual(utils.perft(board,3), 89890)
        self.assertEqual(utils.perft(board,4), 3894594)



if __name__ == "__main__":
    unittest.main()
    #board= Board.from_fen("r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1")
    #board.debug_perft(6)
    #board = Board.starting()
    #utils.perft(board,7, debug = True),
    #native_perft(Board(),6)
    #native_perft(Board(), 6)
