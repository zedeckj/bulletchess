import sys
sys.path.append("./")
import unittest
import random
import time
import chess
from bulletchess import Board, Move

def chess_perft(board : chess.Board, depth : int):
    if depth == 0:
        return 1
    elif depth == 1:
        return board.legal_moves.count()
    else:
        moves = list(board.legal_moves)
        if len(moves) == 0:
            return 1
        nodes = 0
        for move in moves:
            board.push(move)
            nodes += chess_perft(board, depth - 1)
            board.pop()
        return nodes


def native_perft(board : Board, depth : int) -> int:
    if depth == 0:
        return 1
    elif depth == 1:
        return board.count_legal_moves()
    else:
        moves = board.legal_moves()
        if len(moves) == 0:
            return 1
        nodes = 0
        for move in moves:
            undoable = board.apply(move)
            nodes += native_perft(board, depth -1)
            board.undo(undoable)
        return nodes 

class TestPerft(unittest.TestCase):

    def test_native(self):
        board = Board.starting()
        
        self.assertEqual(native_perft(board,0), 1)
        self.assertEqual(native_perft(board,1), 20)
        self.assertEqual(native_perft(board,2), 400)
        self.assertEqual(native_perft(board,3), 8902)
        self.assertEqual(native_perft(board,4), 197281)
        self.assertEqual(native_perft(board,5), 4865609)



    def test_versions(self):
        board = Board.starting()
        t = time.time()
        self.assertEqual(native_perft(board, 5), 4865609)
        t = time.time() - t
        print("Perft times for depth=5, startin position")
        print(f"Native {t}\n")
        t = time.time()
        self.assertEqual(board.perft(5), 4865609)
        t = time.time() - t
        print(f"C {t}\n")
        t = time.time()
        self.assertEqual(chess_perft(chess.Board(), 5), 4865609)
        t = time.time() - t
        print(f"python-chess {t}\n")

    def test_perft(self):
        board = Board.starting()
        
        self.assertEqual(board.perft(0), 1)
        self.assertEqual(board.perft(1), 20)
        self.assertEqual(board.perft(2), 400)
        self.assertEqual(board.perft(3), 8902)
        self.assertEqual(board.perft(4), 197281)
        self.assertEqual(board.perft(5), 4865609)

    def test_pos2(self):
        board= Board.from_fen("r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1")
        self.assertEqual(board.perft(1), 48)
        self.assertEqual(board.perft(2), 2039)
        self.assertEqual(board.perft(3), 97862)
        self.assertEqual(board.perft(4), 4085603)

    def test_pos3(self):
        board = Board.from_fen("8/2p5/3p4/KP5r/1R3p1k/8/4P1P1/8 w - - 0 1")
        self.assertEqual(board.perft(1), 14)
        self.assertEqual(board.perft(2), 191)
        self.assertEqual(board.perft(3), 2812)

    def test_pos4(self):
        board = Board.from_fen("r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1")
        self.assertEqual(board.perft(1), 6)
        self.assertEqual(board.perft(2), 264)
        self.assertEqual(board.perft(3), 9467)
        self.assertEqual(board.perft(4), 422333)

    def test_pos5(self):
        board = Board.from_fen("rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPP1NnPP/RNBQK2R w KQ - 1 8  ")
        self.assertEqual(board.perft(1), 44)
        self.assertEqual(board.perft(2), 1486)
        self.assertEqual(board.perft(3), 62379)

    def test_pos6(self):
        board = Board.from_fen("r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10 ")
        self.assertEqual(board.perft(1), 46)
        self.assertEqual(board.perft(2), 2079)
        self.assertEqual(board.perft(3), 89890)
        self.assertEqual(board.perft(4), 3894594)

        

if __name__ == "__main__":
    unittest.main()
