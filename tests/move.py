import sys
sys.path.append("./")
import unittest
import bulletchess
import chess
import testing_utils
import random
import time


class TestMove(unittest.TestCase):

    def test_serialize(self):
        chess_boards = [testing_utils.random_chess_board() for _ in range(10)]
        ucis = []
        for board in chess_boards:
            ucis.extend([move.uci() for move in board.legal_moves])
        for uci in ucis:
            move = bulletchess.Move.from_uci(uci)
            uci2 = str(move)
            self.assertEqual(uci, uci2)
            

    def test_apply(self):
        COUNT = 1000
        chess_boards = [testing_utils.random_chess_board() for _ in range(COUNT)]
        bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
        moves = []
        for i in range(COUNT):
            chs = chess_boards[i]
            blt = bullet_boards[i]
            moves = list(chs.legal_moves)
            if len(moves) == 0:
                continue
            move = random.choice(moves)
            uci = move.uci()
            blt_move = bulletchess.Move.from_uci(uci)
            original = str(chs)
            chs.push(move)
            
            blt.apply(blt_move)
            self.assertEqual(chs.fen(en_passant="fen"), blt.fen(), msg = f"TEST {i}, MOVE {uci} BEFORE\n\n{original}\nAFTER\n\n{str(chs)}\n")

    def test_pseudo_legal_no_castling(self):
        COUNT = 1000
        chess_boards = [testing_utils.random_chess_board() for _ in range(COUNT)]
        bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
        for i in range(COUNT):
            moves = {m.uci() for m in list(chess_boards[i].pseudo_legal_moves) if not chess_boards[i].is_castling(m)}
            moves2 = {str(m) for m in bullet_boards[i].pseudo_legal_moves()}
            sorted(moves)
            sorted(moves2)
            for move in moves2:
                self.assertIn(move, moves, msg = f"\nFor Board:\n\n{str(chess_boards[i])}\nGenerated: {sorted(list(moves2))}")
            for move in moves:
               self.assertIn(move, moves2, msg = f"\nFor Board:\n\n{str(chess_boards[i])}")

    def test_pseudo_legal_speed(self):
        COUNT = 1000
        chess_boards = [testing_utils.random_chess_board() for _ in range(COUNT)]
        bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
        t = time.time()
        for i in range(COUNT):
            list(chess_boards[i].legal_moves)
        t = time.time() - t
        time.sleep(2)
        t2 = time.time()
        for i in range(COUNT):
            bullet_boards[i].pseudo_legal_moves()
        t2 = time.time() - t2
        print(f"\nFinding Pseudo Legal Moves for {COUNT} boards took:\npython-chess: {t}\nbullet-chess: {t2}\n")
        self.assertLess(t2, t)

        

    def test_legal_no_castling_no_checks(self):
        COUNT = 1000
        chess_boards = []
        while len(chess_boards) < COUNT:
            board = testing_utils.random_chess_board()
            if not board.is_check():
                chess_boards.append(board)        
        bullet_boards = [testing_utils.make_bullet_from_chess(board) for board in chess_boards]
        for i in range(COUNT):
            moves = {m.uci() for m in list(chess_boards[i].legal_moves) if not chess_boards[i].is_castling(m)}
            moves2 = {str(m) for m in bullet_boards[i].legal_moves()}
            sorted(moves)
            sorted(moves2)
            for move in moves2:
                self.assertIn(move, moves, msg = f"\nFor Board:\n\n{str(chess_boards[i])}\nGenerated: {sorted(list(moves2))}")
            #for move in moves:
            #    self.assertIn(move, moves2, msg = f"\nFor Board:\n\n{str(chess_boards[i])}")


if __name__ == "__main__":
    unittest.main()