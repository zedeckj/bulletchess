import unittest
import sys
sys.path.append("./")
from bulletchess import *

FILEPATH = "/Users/jordan/Documents/C/ChessLibrary/tests/pgn/Modern.pgn"

class TestPGN(unittest.TestCase):

    def assertMoveEq(self, move, uci):
        self.assertEqual(move, Move.from_uci(uci))

    def assertMovesAre(self, game : Game, move_sans : list[str]):
        board, moves = game.board_moves()
        print(board)
        print(board.fen())
        
        self.assertEqual(board, Board())
        for i in range(len(move_sans)):
            san = moves[i].to_san(board)
            self.assertEqual(san, move_sans[i])
            board.apply(moves[i])
       

    def test_no_logs(self):
        games = 1
        max_count = 0
        with PGNReader.open(FILEPATH) as f:
            game = f.next_game()
            while game != None: 
                print("\033[93m" +"on game" + '\033[95m'
, games)
                game = f.next_game()
                if game != None and game.move_count > max_count:
                    max_count = game.move_count
                games += 1
        print(f"max count {max_count}")
    
if __name__ == "__main__":
    unittest.main()
