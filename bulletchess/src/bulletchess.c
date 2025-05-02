#include "bulletchess.h"
#include "fen.h"
#include "rules.h"
#include "hash.h"
#include "utils.h"
#include <limits.h>
#include "pgn.h"

static char rand_state[256];
static zobrist_table_t *zobrist_table;

static PyTypeObject PyBoardType;

static void PyTypeErr(char * expected, PyObject *obj){
	char *article;
	switch (expected[0]) {
		case 'a': case 'e': case 'i': case 'o': case 'u': case 'y':
		case 'A': case 'E': case 'I': case 'O': case 'U': case 'Y':
		article = "an";
		break;
		default:
		article = "a";
	}
	PyErr_Format(PyExc_TypeError, "Expected %s %s, got %S (%N)", 
		article, expected, obj, Py_TYPE(obj));
}


static void PyGeneric_Dealloc(PyObject *self){
	Py_TYPE(self)->tp_free(self);
}

static bool PyTypeCheck(char *expected, PyObject *obj, PyTypeObject *type){
	if (!Py_IS_TYPE(obj, type)) {
		PyTypeErr(expected, obj);		
		return false;	
	}
	return true;
}

/* Square CLASS */

typedef struct {
	PyObject_HEAD
	square_t square;
} PySquareObject;

static PySquareObject *PySquares[64];


static bool PySquares_init() {
	for (square_t sq = A1; sq <= H8; sq++) {
		PySquareObject *py_square = 
			PyObject_New(PySquareObject, &PySquareType);
		if (!py_square){
			for (square_t s2 = A1; s2 < sq; s2++)
				Py_TYPE(PySquares[s2])->tp_free((PyObject *)PySquares[s2]);
			return false;
		}
		else {
			py_square->square = sq;
			PySquares[sq] = py_square;
		}
	}
	return true;
}

static PyObject *PySquare_make(square_t square) {
	return (PyObject *)PySquares[square];
}

static inline square_t PySquare_get(PyObject *self) {
	return ((PySquareObject *)self)->square;
}

static PyObject *PySquare_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PySquareType) && 
		PySquare_get(self) == PySquare_get(other); 	
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			return Py_NotImplemented;
	}
}

static Py_hash_t PySquare_hash(PyObject *self){
	return PySquare_get(self);
}

static PyObject *PySquare_from_optional(optional_square_t opt) {
	if (opt.exists) {
		return PySquare_make(opt.square);
	}
	else Py_RETURN_NONE;
}

static PyObject *PySquare_str(PyObject *self) {
	char buffer[3];
	serialize_sqr_caps(PySquare_get(self), buffer);
	return PyUnicode_FromString(buffer);
}

// too verbose for nested structures
static PyObject *PySquare_repr(PyObject *self) {
	char buffer[3];
	serialize_sqr_caps(PySquare_get(self), buffer);
	return PyUnicode_FromFormat("<Square: %s>", buffer);
}


static PyTypeObject PySquareType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Square",
	.tp_basicsize = sizeof(PySquareObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PySquare_str,
	.tp_richcompare = PySquare_compare,
	.tp_repr = PySquare_str,
	.tp_hash = PySquare_hash
};


/* PieceType CLASS */

typedef struct {
	PyObject_HEAD
	piece_type_t piece_type;
} PyPieceTypeObject;


static PyPieceTypeObject *PieceTypeObjects[6];

static inline piece_type_t PyPieceType_get(PyObject *self){
	return ((PyPieceTypeObject *)self)->piece_type;
}

static bool PyPieceTypes_init(){
	for (piece_type_t pt = PAWN_VAL; pt <= KING_VAL; pt++){
		PyPieceTypeObject *py_piece_type = 
			PyObject_New(PyPieceTypeObject, &PyPieceTypeType);	
		if (!py_piece_type) {
			for (piece_type_t pt2 = PAWN_VAL; pt2 < pt; pt2++) 
				Py_TYPE(PySquares[pt2])->tp_free((PyObject *)PySquares[pt2]);
			return false;
		}
		else {
			py_piece_type->piece_type = pt;
			PieceTypeObjects[pt - PAWN_VAL] = py_piece_type;	
		}
	}
	return true;
}

static PyObject *PyPieceType_make(piece_type_t piece_type) {
	return (PyObject *)PieceTypeObjects[piece_type - PAWN_VAL];
}


static PyObject *PyPieceType_str(PyObject *self){
	piece_type_t pt = PyPieceType_get(self);
	const char *str = get_piece_name(pt);
	if (str){
		return PyUnicode_FromString(str);
	}
	PyErr_Format(PyExc_AttributeError, 
			"Illegal PieceType with value %d", pt);
	return NULL;
}


PyObject *PyPieceType_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PyPieceTypeType) && PyPieceType_get(self) == PyPieceType_get(other); 	
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			return Py_NotImplemented;
	}
}


Py_hash_t PyPieceType_hash(PyObject *self) {
	return PyPieceType_get(self);
}


static PyTypeObject PyPieceTypeType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.PieceType",
	.tp_basicsize = sizeof(PyPieceTypeObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PyPieceType_str,
	.tp_richcompare = PyPieceType_compare,
	.tp_repr = PyPieceType_str,
	.tp_hash = PyPieceType_hash
};



/* Color CLASS */

typedef struct {
	PyObject_HEAD
	piece_color_t color;
} PyColorObject; 

static PyColorObject *WhiteObject;
static PyColorObject *BlackObject;

static bool PyColors_init() {
	WhiteObject = PyObject_New(PyColorObject, &PyColorType);
	if (!WhiteObject) return false;
	BlackObject = PyObject_New(PyColorObject, &PyColorType);
	if (!BlackObject){
    Py_TYPE(WhiteObject)->tp_free((PyObject *) WhiteObject);
		return false;
	}	
	WhiteObject->color = WHITE_VAL;
	BlackObject->color = BLACK_VAL;
	return true;
}
static PyObject *PyColor_make(piece_color_t color) {
	switch (color) {
		case WHITE_VAL: return (PyObject *)WhiteObject;
		case BLACK_VAL: return (PyObject *)BlackObject;
		default:
			PyErr_SetString(PyExc_ValueError, "Invalid color generated");
			return NULL;
	}
}

static inline piece_color_t PyColor_get(PyObject *self) {
	return ((PyColorObject *)self)->color;
}

static PyObject *PyColor_str(PyObject *self) {
	piece_color_t color = PyColor_get(self);
	switch(color) {
		case WHITE_VAL:
			return PyUnicode_FromString("White");
		case BLACK_VAL:
			return PyUnicode_FromString("Black");
		default:
			PyErr_Format(PyExc_AttributeError, 
					"Illegal Color with value %d", color);
			return NULL;
	}
}


PyObject *PyColor_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PyColorType) && PyColor_get(self) == PyColor_get(other); 	
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			return Py_NotImplemented;
	}
}

Py_hash_t PyColor_hash(PyObject *self) {
	return (PyColor_get(self) + 1);
}


static PyTypeObject PyColorType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Color",
	.tp_basicsize = sizeof(PyColorObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = (reprfunc)PyColor_str,
	.tp_richcompare = PyColor_compare,
	.tp_repr = PyColor_str,
	.tp_hash = PyColor_hash
};



/* Piece CLASS */


typedef struct {
	PyObject_HEAD
	piece_t piece;
} PyPieceObject; 




// Returns None if given an EMPTY_VAL piece
static PyObject *PyPiece_make(piece_t piece) {
	if (piece.type == EMPTY_VAL) Py_RETURN_NONE;
	PyPieceObject *py_piece = PyObject_New(PyPieceObject, &PyPieceType);
	if (!py_piece) return NULL;
	py_piece->piece = piece;
	return (PyObject *)py_piece;
}

static int
PyPiece_init(PyObject *self, PyObject *args, PyObject *kwds){
		PyObject *color;
		PyObject *piece_type;
		if (!PyArg_ParseTuple(args, "OO", &color, &piece_type)) {
			return -1;
		}
		if (!PyTypeCheck("Color", color, &PyColorType)) return -1;
		if (!PyTypeCheck("PieceType", piece_type, &PyPieceTypeType)) return -1;
  	piece_t piece = {
			.type = PyPieceType_get(piece_type), 
			.color = PyColor_get(color)
		};
		((PyPieceObject *)self)->piece = piece;	
		return 0;
}

static inline piece_t PyPiece_get(PyObject *self) {
	return ((PyPieceObject *)self)->piece;
}


static PyObject *PyPiece_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PyPieceType); 	
	if (eq) {
		piece_t p1 = PyPiece_get(self);
		piece_t p2 = PyPiece_get(other);
		eq = p1.color == p2.color && p1.type == p2.type;
	}
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			return Py_NotImplemented;
	}
}

static Py_hash_t PyPiece_hash(PyObject *self) {
	return hash_piece(PyPiece_get(self));
}

static PyObject *PyPiece_repr(PyObject *self) {
	piece_t p = PyPiece_get(self);
	const char *color;
	const char *type;
	switch (p.color) {
		case WHITE_VAL:
			color = "White";
			break;
		case BLACK_VAL:
			color ="Black";
			break;
	}
	type = get_piece_name(p.type);
	if (!type) {
		PyErr_Format(PyExc_AttributeError, "Illegal PieceType with value %d", p.type);
	}
	return PyUnicode_FromFormat("<Piece: (%s, %s)>", color, type);
}


static PyObject *PyPiece_color_get(PyObject *self, void *closure) {
	return PyColor_make(PyPiece_get(self).color);
}


static PyObject *PyPiece_type_get(PyObject *self, void *closure) {
	return PyPieceType_make(PyPiece_get(self).type);
}



static PyGetSetDef PyPiece_getset[] = {
    {"color", (getter)PyPiece_color_get, NULL, NULL, NULL},
    {"piece_type", (getter)PyPiece_type_get, NULL, NULL, NULL},
		{NULL}
};


static PyTypeObject PyPieceType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Piece",
	.tp_basicsize = sizeof(PyPieceObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_init = PyPiece_init,
	.tp_new = PyType_GenericNew,
	.tp_repr = (reprfunc)PyPiece_repr,
	.tp_richcompare = PyPiece_compare,
	.tp_hash = PyPiece_hash,
	.tp_getset = PyPiece_getset,
	//.tp_dealloc = PyGeneric_Dealloc
};



/* Move CLASS */
typedef struct {
	PyObject_HEAD
	move_t move;	
} PyMoveObject;


static PyMoveObject* PyMove_make(move_t move) {
	PyMoveObject *self = PyObject_New(PyMoveObject, &PyMoveType);
	if (!self) return NULL;
  self->move = move;
  return self;
}

static inline move_t PyMove_get(PyObject *self) {
	return ((PyMoveObject *)self)->move;
}

// returns true if an err was raised
static bool PyRaiseIfErr(char *err) {
 	if (err) {
		char buffer[300];
		strcpy(buffer, err);
		free(err);
		PyErr_SetString(PyExc_ValueError, buffer);
		return true;
	}	
	return false;
}	


// Creates a PyObject from a move which may be a null move,
// which is represented as None or an Error
static PyObject *PyMove_from_opt(move_t move) {
	switch (move.type) {
		case NULL_MOVE:
			Py_RETURN_NONE;
		case ERROR_MOVE:
			PyErr_SetString(PyExc_ValueError, "Illegal Move found");
			return NULL;
		default:
			return (PyObject *)PyMove_make(move);
	}
}

static PyObject *PyMove_from_uci(PyObject *self, PyObject *args) {
	const char *uci = PyUnicode_AsUTF8AndSize(args, NULL);
	if (!uci) return NULL;
	move_t move;
	char *err = parse_uci(uci, &move);	
	if (PyRaiseIfErr(err)) return NULL;
	return PyMove_from_opt(move);
}


static PyObject *PyMove_repr(PyObject *self) {
	char uci[10];
	if (write_uci(PyMove_get(self), uci)) {
		return PyUnicode_FromFormat("<Move: %s>", uci);
	}
	else {
		return PyUnicode_FromString("<Move: \?\?\?\?>");
	}	
}


static bool PyMove_validate_val(move_t m) {
	char *err = error_from_move(m);
	return !PyRaiseIfErr(err);
}


static inline full_board_t *PyBoard_board(PyObject *obj);

static PyObject *PyMove_from_san(PyObject *self, PyObject *args) {
	PyObject *san_obj;
	PyObject *board;
	if (!PyArg_ParseTuple(args, "OO", &san_obj, &board)) return NULL;
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL;
	if (!PyTypeCheck("str", san_obj, &PyUnicode_Type)) return NULL;
	char *san = PyUnicode_AsUTF8(san_obj);
	bool err = false;
	char err_msg[300];
	move_t move = san_str_to_move(PyBoard_board(board), san, &err, err_msg);
	if (err) {
		PyErr_SetString(PyExc_ValueError, err_msg);
		return NULL;
	}
	return (PyObject *)PyMove_make(move);
}

static PyObject *PyMove_to_san(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	char san[30];
	if (move_to_san_str(PyBoard_board(arg), PyMove_get(self), san)) {
		return PyUnicode_FromString(san);
	}
	else {
		PyErr_Format(PyExc_ValueError, "Cannot convert Move to san, "
				"%R is illegal for %R ", self, arg);
		return NULL;
	}
}

static PyObject *PyMove_to_uci(PyObject *self, PyObject *Py_UNUSED(args)) {
	char uci[10];
	if (write_uci(PyMove_get(self), uci)) {
		return PyUnicode_FromString(uci);
	}
	else {
		PyErr_SetString(PyExc_ValueError, "Cannot convert Move to uci");
		return NULL;
	}	
}



static int
PyMove_init(PyObject *self, PyObject *args, PyObject *kwargs){
		PyObject *origin;
		PyObject *destination;
		PyObject *promote_to = NULL;
    static char *kwlist[] = {"origin", "destination", "promote_to", NULL};
		if (!PyArg_ParseTupleAndKeywords(args, kwargs, "OO|O", kwlist, &origin, &destination, &promote_to)) {
			return -1;
		}
		if (!PyTypeCheck("origin Square", origin, &PySquareType)) return -1;
		if (!PyTypeCheck("destination Square", destination, &PySquareType)) return -1;
		if (promote_to && !Py_IS_TYPE(promote_to, &PyPieceTypeType) && !Py_IsNone(promote_to)) {
			PyErr_Format(PyExc_TypeError, "Expected a PieceType or None for promote_to, got %S (%N)", promote_to, Py_TYPE(promote_to));
			return -1;
		}
		square_t origin_v = PySquare_get(origin);
		square_t dest_v = PySquare_get(destination);
		piece_type_t type_v = promote_to ? PyPieceType_get(promote_to) : EMPTY_VAL;
		move_t move = make_move_from_parts(origin_v, dest_v, type_v); 
		if (PyMove_validate_val(move)){
			((PyMoveObject *)self)->move = move;
			return 0;
		}
		return -1;
}	

static PyObject* PyMove_get_origin(PyObject *self, void *closure) {
	return PySquare_make(get_origin(PyMove_get(self)));
}

static PyObject* PyMove_get_destination(PyObject *self, void *closure){
	return PySquare_make(get_destination(PyMove_get(self)));
}

static PyObject* PyMove_get_promote_to(PyObject *self, void *closure) {
	piece_type_t pt = get_promotes_to(PyMove_get(self));
	if (pt == EMPTY_VAL) Py_RETURN_NONE;
	else return PyPieceType_make(pt);
}

PyObject *PyMove_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PyMoveType);
 	if (eq) {
		move_t m1 = PyMove_get(self);
		move_t m2 = PyMove_get(other);
		eq = moves_equal(m1, m2);	
	}
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			return Py_NotImplemented;
	}
}


Py_hash_t PyMove_hash(PyObject *self){
	return hash_move(PyMove_get(self));
}



static PyMethodDef PyMove_methods[] = { 
    {"from_uci", PyMove_from_uci, METH_O | METH_STATIC, NULL}, 
    {"from_san", PyMove_from_san, METH_VARARGS | METH_STATIC, NULL}, 
		{"san", PyMove_to_san, METH_O, NULL}, 
		{"uci", PyMove_to_uci, METH_NOARGS, NULL}, 
		{NULL, NULL, 0, NULL}
};


static PyGetSetDef PyMove_getset[] = {
    {"origin", (getter)PyMove_get_origin, NULL, NULL, NULL},
    {"destination", (getter)PyMove_get_destination, NULL, NULL, NULL},
    {"promotion", (getter)PyMove_get_promote_to, NULL, NULL, NULL},
		{NULL}
};





static PyTypeObject PyMoveType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Move",
	.tp_basicsize = sizeof(PyMoveObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT,
  .tp_new = PyType_GenericNew,
	.tp_init = PyMove_init,
	.tp_methods = PyMove_methods,
	.tp_getset = PyMove_getset,
	.tp_richcompare = PyMove_compare,
	.tp_hash = PyMove_hash,
	//.tp_dealloc = PyGeneric_Dealloc,
	.tp_repr = PyMove_repr,
	.tp_str = PyMove_to_uci,
};


/* Bitboard Clas */

typedef struct {
	PyObject_HEAD
	bitboard_t bitboard;
} PyBitboardObject;

static PyTypeObject PyBitboardType;

static PyBitboardObject *PyBitboard_make(bitboard_t bitboard){
	PyBitboardObject *self = PyObject_New(PyBitboardObject, &PyBitboardType);
	if (!self) return NULL;
	self->bitboard = bitboard;
	return self;
}	

static inline bitboard_t PyBitboard_get(PyObject *self) {
	return ((PyBitboardObject *)self)->bitboard;
}

static PyObject *PyBitboard_and(PyObject *self, PyObject *other) {
	if (!PyTypeCheck("Bitboard", other, &PyBitboardType)) return NULL;
	bitboard_t b1 = PyBitboard_get(self);
	bitboard_t b2 = PyBitboard_get(other);
	return (PyObject *)PyBitboard_make(b1 & b2);
}


static PyObject *PyBitboard_xor(PyObject *self, PyObject *other) {
	if (!PyTypeCheck("Bitboard", other, &PyBitboardType)) return NULL;
	bitboard_t b1 = PyBitboard_get(self);
	bitboard_t b2 = PyBitboard_get(other);
	return (PyObject *)PyBitboard_make(b1 ^ b2);
}


static PyObject *PyBitboard_or(PyObject *self, PyObject *other) {
	if (!PyTypeCheck("Bitboard", other, &PyBitboardType)) return NULL;
	bitboard_t b1 = PyBitboard_get(self);
	bitboard_t b2 = PyBitboard_get(other);
	return (PyObject *)PyBitboard_make(b1 | b2);
}


static PyObject *PyBitboard_not(PyObject *self) {
	bitboard_t b1 = PyBitboard_get(self);
	return (PyObject *)PyBitboard_make(~b1);
}



static PyObject *PyBitboard_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PyBitboardType) 
		&& PyBitboard_get(self) == PyBitboard_get(other); 	
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			return Py_NotImplemented;
	}
}

static int PyBitboard_contains(PyObject *self, PyObject *value) {
	if (!PyTypeCheck("Square", value, &PySquareType)) return -1;
	bitboard_t bb = PyBitboard_get(self);
	square_t sq = PySquare_get(value);
	return bb & SQUARE_TO_BB(sq) ? 1 : 0;
}


static PyObject *PyBitboard_to_int(PyObject *self) {
	bitboard_t bb = PyBitboard_get(self);
	return PyLong_FromUnsignedLong(bb);
}

static Py_ssize_t PyBitboard_len(PyObject *self) {
	return (Py_ssize_t)count_bits(PyBitboard_get(self));
}

static PyObject *PyBitboard_getitem(PyObject *self, PyObject *key){
	int cont = PyBitboard_contains(self, key);
	switch (cont) {
		case 0: return Py_False;
		case 1: return Py_True;
		default: return NULL;
	}
}


static int PyBitboard_setitem(PyObject *self, PyObject *key, PyObject *value){
	if (!PyTypeCheck("Square", key, &PySquareType)) return -1;
	square_t sq = PySquare_get(key);
	if (!value || Py_IsFalse(value)) {
		((PyBitboardObject *)self)->bitboard &= ~SQUARE_TO_BB(sq); 
		return 0;
	}
	else if (Py_IsTrue(value)) {
		((PyBitboardObject *)self)->bitboard |= SQUARE_TO_BB(sq); 
		return 0;
	}
	else {
		PyTypeErr("bool", value);	
		return -1;
	}
}


static int
PyBitboard_init(PyObject *self, PyObject *args, PyObject *kwds){
		PyObject *square_set;
		if (!PyArg_ParseTuple(args, "O", &square_set)) return -1;
		//if (!PyTypeCheck("set", square_set, &PySet_Type)) return -1;
		PyObject *iter;
		if (!(iter = PyObject_GetIter(square_set))) {
			PyTypeErr("Iterable", square_set);
			return -1;
		}
		PyObject *next;
		bitboard_t bb = 0;
		while ((next = PyIter_Next(iter))){
			if (!PyTypeCheck("Square", next, &PySquareType)){		
				Py_DECREF(next);	
				return -1;
			}
			bb |= SQUARE_TO_BB(PySquare_get(next));
			Py_DECREF(next);	
		}
		Py_DECREF(iter);
		((PyBitboardObject *)self)->bitboard = bb;
		return 0;
}

static PyObject *PyBitboard_squares_iter(PyObject *self) {
	bitboard_t src = PyBitboard_get(self);
	u_int8_t len = count_bits(src);
	PyObject *list = PyList_New(len);
	u_int8_t i = 0;	
	forbitboard(bit, src){
		square_t sq = unchecked_bb_to_square(bit);
		PyList_SET_ITEM(list, i++, PySquare_make(sq));
	}
	return PyObject_GetIter(list);
}


static PyObject *PyBitboard_repr(PyObject *self){
	bitboard_t bb = PyBitboard_get(self);
	return PyUnicode_FromFormat("<Bitboard: 0x%lX>", bb);
}


static PyObject *PyBitboard_from_int(PyObject *cls, PyObject *arg){ 
	if (!PyTypeCheck("int", arg, &PyLong_Type)) return NULL;
	bitboard_t bb = PyLong_AsUnsignedLongLong(arg);
	if (bb == -1 && PyErr_Occurred()) return NULL;
	return (PyObject *)PyBitboard_make(bb);	
}


static PyMappingMethods PyBitboardAsMap = {
	.mp_subscript = PyBitboard_getitem,
	.mp_ass_subscript = PyBitboard_setitem,
	.mp_length = PyBitboard_len,
};


static PySequenceMethods PyBitboardAsSeq= {
	.sq_contains = PyBitboard_contains,
};



static PyNumberMethods PyBitboardAsNum = {
	.nb_int = PyBitboard_to_int,
	.nb_xor = PyBitboard_xor,
	.nb_or = PyBitboard_or,
	.nb_and = PyBitboard_and,
	.nb_invert = PyBitboard_not,
};


static PyMethodDef PyBitboardMethods[] = {
	{"from_int", PyBitboard_from_int, METH_O | METH_STATIC, NULL},
	{NULL, NULL, 0, NULL},
};

static PyTypeObject PyBitboardType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Bitboard",
	.tp_basicsize = sizeof(PyBitboardObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_new = PyType_GenericNew,
	.tp_init = PyBitboard_init,
	.tp_richcompare = PyBitboard_compare,
	.tp_as_mapping = &PyBitboardAsMap,
	.tp_as_number = &PyBitboardAsNum,
	.tp_as_sequence = &PyBitboardAsSeq,
	.tp_iter = PyBitboard_squares_iter,
	.tp_methods = PyBitboardMethods,
	.tp_repr = PyBitboard_repr,
	//.tp_dealloc = PyGeneric_Dealloc
};



/* Board CLASS */

typedef struct {
	PyObject_HEAD
	full_board_t *board;
	undoable_move_t *move_stack;
	size_t stack_size;
	size_t stack_capacity;
} PyBoardObject;



static PyBoardObject* PyBoard_alloc() {
	PyBoardObject *self = PyObject_New(PyBoardObject, &PyBoardType);
	if (!self) return NULL;
  self->board = PyMem_RawMalloc(sizeof(full_board_t));
	if (!self->board) return NULL;
	self->board->position = PyMem_RawMalloc(sizeof(position_t));
	if (!self->board->position) return NULL;
	self->stack_capacity = 5;
	self->move_stack = PyMem_RawMalloc(self->stack_capacity * sizeof(undoable_move_t));	
	if (!self->move_stack) return NULL;
	self->stack_size = 0;
	return self;
}

static void PyBoard_dealloc(PyBoardObject *self) {
		PyMem_RawFree(self->board->position);
		PyMem_RawFree(self->board);
		PyMem_RawFree(self->move_stack);
		Py_TYPE(self)->tp_free((PyObject *)self);
}


// Gets the address of a board from a PyObject* known to be
// a PyBoardObject*
static inline full_board_t *PyBoard_board(PyObject *obj){
	PyBoardObject *b = (PyBoardObject *)obj;
	return b->board;
}

static PyObject *PyBoard_from_fen_str(const char *fen) {
	PyBoardObject *board = PyBoard_alloc();	
	if (!board) return NULL;
	char *err = parse_fen(fen, board->board); 
	if (err) {
		PyErr_Format(PyExc_ValueError,"Invalid FEN \'%s\': %s", fen, err);	
		Py_DECREF(board);
		return NULL;
	}
	return (PyObject *)board;
}

static PyObject *PyBoard_from_fen(PyObject *cls, PyObject *args) {
	const char *fen = PyUnicode_AsUTF8AndSize(args, NULL);
	if (!fen) return NULL;
	return PyBoard_from_fen_str(fen);
}

static void PyBoard_setup_starting(PyObject *self) {
	const char *fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
	parse_fen(fen, PyBoard_board(self)); 
}

static bool PyBoard_apply_struct(PyBoardObject *board_obj, move_t move);


static PyObject *PyBoard_empty(PyObject *cls, PyObject *Py_UNUSED(args)) {
	PyBoardObject *board_obj = PyBoard_alloc();
	if (!board_obj) return NULL;
	full_board_t *board = board_obj->board;
	position_t *pos = board->position;
	memset(pos, 0, sizeof(position_t));
	board->fullmove_number = 1;
	board->halfmove_clock = 0;
	board->castling_rights = 0;
	board->en_passant_square.exists = false;
	board->turn = WHITE_VAL;
	return (PyObject *)board_obj;
}


static int
Board_init(PyObject *self, PyObject *args, PyObject *kwds)
{
    if (!PyArg_UnpackTuple(args, "Board", 0, 0) ||  
        (kwds && PyDict_Size(kwds))) {
        PyErr_SetString(PyExc_TypeError,
    	"Board() creates a Board representing the starting position, "
      "and takes no arguments. Use Board.from_fen() to create a Board "
			"for a different position.");
        return -1;
    }
		PyBoard_setup_starting(self);
    return 0;
}


static PyObject *
PyBoard_to_fen(PyObject *self, PyObject *Py_UNUSED(args)){
	char fen_buffer[128];
	make_fen(PyBoard_board(self), fen_buffer);
	return PyUnicode_FromString(fen_buffer);
}


static PyObject *
PyBoard_repr(PyObject *self, PyObject *Py_UNUSED(args)){
	char fen_buffer[128];
	make_fen(PyBoard_board(self), fen_buffer);
	return PyUnicode_FromFormat("<Board: %s>", fen_buffer);
}

static PyObject *
PyBoard_legal_moves(PyObject *self, PyObject *Py_UNUSED(args)){
	move_t move_buffer[300];
	u_int8_t count = generate_legal_moves(PyBoard_board(self), move_buffer);		
	PyObject *list = PyList_New(count);
	for (int i = 0; i < count; i++) {
		PyMoveObject *move_obj = PyMove_make(move_buffer[i]);
		PyList_SET_ITEM(list, i, move_obj);
	}
	return list;
}


static bool PyBoard_set_capacity(PyBoardObject *board, size_t new_capacity) {
	void *new_stack = PyMem_RawRealloc(board->move_stack, 
											new_capacity * sizeof(undoable_move_t));
	if (!new_stack) return false;
	board->move_stack = new_stack;
	board->stack_capacity = new_capacity;
	return true;	
}

static PyObject *PyBoard_copy(PyObject *self, PyObject *Py_UNUSED(args)){
	PyBoardObject *copy_obj = PyBoard_alloc();
	if (!copy_obj) return NULL;
	full_board_t *copy = copy_obj->board; 
	full_board_t *src = PyBoard_board(self);
	copy_into(copy, src);
	size_t stack_size = ((PyBoardObject *)self)->stack_size;
	size_t stack_capacity= ((PyBoardObject *)self)->stack_capacity;
	undoable_move_t * src_stack = ((PyBoardObject *)self)->move_stack;
	if (!PyBoard_set_capacity(copy_obj, stack_capacity)) {
		PyErr_SetString(PyExc_MemoryError, "Could not copy Board, out of memory");
		Py_DECREF(copy_obj);
		return NULL;
	}
	memcpy(copy_obj->move_stack, src_stack, sizeof(undoable_move_t) * stack_size);
	copy_obj->stack_size = stack_size;
	return (PyObject *)copy_obj;
}



static bool PyBoard_apply_struct(PyBoardObject *board_obj, move_t move){
	undoable_move_t undo = apply_move(board_obj->board, move);
	if (board_obj->stack_size == board_obj->stack_capacity) {
		size_t new_capacity = board_obj->stack_capacity * 2;
		void *new_ptr = PyMem_RawRealloc(board_obj->move_stack, sizeof(undoable_move_t) * new_capacity);
		if (new_ptr) board_obj->move_stack = new_ptr;
		else {
			PyErr_SetString(PyExc_MemoryError, "Could not apply move, out of memory");
			return false;
		}
		board_obj->stack_capacity = new_capacity;
	}
	board_obj->move_stack[board_obj->stack_size++] = undo;	
	return true;
}




static PyObject *
PyBoard_apply(PyObject *self, PyObject *move){
	move_t move_s;
	if (Py_IsNone(move)){
		move_s = null_move();
	}
	else {
		if (!PyTypeCheck("Move", move, &PyMoveType)) return NULL;
		move_s = PyMove_get(move);
	}
	PyBoardObject *board_obj = (PyBoardObject *) self;
	if (!PyBoard_apply_struct(board_obj, move_s)) return NULL;
	Py_RETURN_NONE;	
}


static PyObject *
PyBoard_undo(PyObject *self, PyObject *Py_UNUSED(args)){
	PyBoardObject *board_obj = (PyBoardObject *) self;
	if (board_obj->stack_size == 0) {
		PyErr_SetString(PyExc_AttributeError, "No moves to undo");
		return NULL;
	}
	undoable_move_t undo = board_obj->move_stack[--(board_obj->stack_size)];
	undo_move(board_obj->board, undo);
	move_t move = undo.move;
	if (move.type == NULL_MOVE) {
		Py_RETURN_NONE;
	}
	return (PyObject *)PyMove_make(move);	
}

PyObject *PyBoard_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PyBoardType);
 	if (eq) {
		full_board_t *b1= PyBoard_board(self);
		full_board_t *b2 = PyBoard_board(other);
		eq = boards_equal(b1, b2);
	}
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			return Py_NotImplemented;
	}
}


PyObject *PyBoard_get_piece_at(PyObject *self, PyObject *key) {
	if (!PyTypeCheck("Square", key, &PySquareType)) return NULL;
	square_t square = PySquare_get(key);	
	full_board_t *board = PyBoard_board(self);
	piece_t piece = get_piece_at(board->position, square);
	return PyPiece_make(piece);	
}


int PyBoard_set_piece_at(PyObject *self, PyObject *key, PyObject *val) {	
	if (!PyTypeCheck("Square", key, &PySquareType)) return -1;
	square_t square = PySquare_get(key);	
	full_board_t *board = PyBoard_board(self);
	if (!val || Py_IsNone(val)) {
		delete_piece_at(board->position, square);
		return 0;
	}
	else if (!PyTypeCheck("Piece or None", val, &PyPieceType)) 
		return -1;
	else {
		piece_t piece = PyPiece_get(val);
		set_piece_at(board->position, square, piece); 
		return 0;
	}
}

static PyObject *PyBoard_random(PyObject *cls, PyObject *args){
	PyBoardObject *board = PyBoard_alloc();
	if (!board) return NULL;
	setstate(rand_state);
	PyBoard_setup_starting((PyObject *)board);
	u_int8_t depth = 4 + (random() % 100);
	move_t moves[256];
	PyBoard_set_capacity(board, depth * 1.5);	
	for (u_int8_t i = 0; i < depth; i++) {
		u_int8_t count = generate_legal_moves(board->board, moves);
		if (!count) return (PyObject *)board;
		u_int8_t attempts = 0;
		u_int8_t index;
		retry:
		index = random() % count;
		if (attempts++ < 3 && !is_capture(board->board, moves[index])) {
			goto retry;	
		}
		if (!PyBoard_apply_struct(board, moves[index])) {
			Py_DECREF(board);
			return NULL;
		}
	}
	return (PyObject *)board;
}

Py_hash_t PyBoard_hash(PyObject *self){
	return hash_board(PyBoard_board(self), zobrist_table);
}




static PyMethodDef board_methods[] = { 
    {"from_fen", PyBoard_from_fen, METH_O | METH_STATIC, NULL},  
    {"random", PyBoard_random, METH_NOARGS | METH_STATIC, NULL},  
    {"empty", PyBoard_empty, METH_NOARGS | METH_STATIC, NULL},  
		{"fen", PyBoard_to_fen, METH_NOARGS, NULL},
	 	{"legal_moves", PyBoard_legal_moves, METH_NOARGS, NULL},
	 	{"apply", PyBoard_apply, METH_O, NULL},	
	 	{"undo", PyBoard_undo, METH_NOARGS, NULL},	
		{"copy", PyBoard_copy, METH_NOARGS, NULL},
		//{"status", NULL, 0, NULL},
		{NULL, NULL, 0, NULL}
};


static PyObject *PyBoard_ep_square(PyObject *self, void *closure) {
	return PySquare_from_optional(PyBoard_board(self)->en_passant_square);
}


static int PyBoard_ep_set(PyObject *self, PyObject *val){
	if (Py_IsNone(val)) {
		PyBoard_board(self)->en_passant_square.exists = false;
		return 0;
	}
	if (!PyTypeCheck("Square or None", val, &PySquareType)) return -1;
	PyBoard_board(self)->en_passant_square.exists = true;
  PyBoard_board(self)->en_passant_square.square	= PySquare_get(val);	
	return 0;
}



static PyObject *PyBoard_turn_get(PyObject *self, void *closure) {
	return PyColor_make(PyBoard_board(self)->turn);
}

static int PyBoard_turn_set(PyObject *self, PyObject *val){
	if (!PyTypeCheck("Color", val, &PyColorType)) return -1;
	PyBoard_board(self)->turn = PyColor_get(val);	
	return 0;
}

static PyObject *PyBoard_fullmove_get(PyObject *self, void *closure) {
	return PyLong_FromUnsignedLong(PyBoard_board(self)->fullmove_number);
}


static int PyBoard_fullmove_set(PyObject *self, PyObject *val){
	if (!PyTypeCheck("int", val, &PyLong_Type)) return -1;
	long long raw = PyLong_AsUnsignedLongLong(val);
	if (SHRT_MAX < raw) {
		char exp[30];
		sprintf(exp, "a value < %d", SHRT_MAX);
		PyTypeErr(exp, val);
		return -1;
	}	
	PyBoard_board(self)->fullmove_number = raw;	
	return 0;
}



static PyObject *PyBoard_halfmove_get(PyObject *self, void *closure) {
	return PyLong_FromUnsignedLong(PyBoard_board(self)->halfmove_clock);
}


static int PyBoard_halfmove_set(PyObject *self, PyObject *val){
	if (!PyTypeCheck("int", val, &PyLong_Type)) return -1;
	long long raw = PyLong_AsUnsignedLongLong(val);
	if (SHRT_MAX < raw) {
		char exp[30];
		sprintf(exp, "a value < %d", SHRT_MAX);
		PyTypeErr(exp, val);
		return -1;
	}	
	PyBoard_board(self)->halfmove_clock = raw;	
	return 0;
}


static PyObject *PyBoard_pawns(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->pawns);
}

static PyObject *PyBoard_knights(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->knights);
}

static PyObject *PyBoard_bishops(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->bishops);
}

static PyObject *PyBoard_rooks(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->rooks);
}

static PyObject *PyBoard_queens(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->queens);
}

static PyObject *PyBoard_kings(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->kings);
}


static PyObject *PyBoard_white(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->white_oc);
}


static PyObject *PyBoard_black(PyObject *self, void *closure) {
	full_board_t *board = PyBoard_board(self);
	return (PyObject *)PyBitboard_make(board->position->black_oc);
}

static PyObject *PyBoard_empty_bb(PyObject *self, void *closure) {
	position_t *pos= PyBoard_board(self)->position;
	return (PyObject *)PyBitboard_make(
		~(pos->white_oc | pos->black_oc)	
	);
}

static PyGetSetDef Board_getset[] = {
    {"turn", 
			(getter)PyBoard_turn_get, (setter)PyBoard_turn_set, NULL, NULL},
    {"fullmove_number", 
			(getter)PyBoard_fullmove_get, (setter)PyBoard_fullmove_set, NULL, NULL},
    {"halfmove_clock", 
			(getter)PyBoard_halfmove_get, (setter)PyBoard_halfmove_set, NULL, NULL},
    {"en_passant_square", 
			(getter)PyBoard_ep_square, (setter)PyBoard_ep_set, NULL, NULL},
    {"pawns", 
			(getter)PyBoard_pawns, NULL, NULL, NULL},
    {"knights", 
			(getter)PyBoard_knights, NULL, NULL, NULL},
    {"bishops", 
			(getter)PyBoard_bishops, NULL, NULL, NULL},
    {"rooks", 
			(getter)PyBoard_rooks, NULL, NULL, NULL},
    {"queens", 
			(getter)PyBoard_queens, NULL, NULL, NULL},
    {"kings", 
			(getter)PyBoard_kings, NULL, NULL, NULL},
		{"white", 
			(getter)PyBoard_white, NULL, NULL, NULL},
		{"black", 
			(getter)PyBoard_black, NULL, NULL, NULL},
		{"unoccupied",
			PyBoard_empty_bb, NULL, NULL, NULL},	
		
		{NULL}
};

static PyMappingMethods PyBoardAsMap = {
	.mp_subscript = PyBoard_get_piece_at,
	.mp_ass_subscript = PyBoard_set_piece_at,
	.mp_length = NULL,
};

static PyTypeObject PyBoardType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Board",
	.tp_basicsize = sizeof(PyBoardObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	//.tp_dealloc = (destructor)PyBoard_dealloc,
	.tp_alloc = (allocfunc)PyBoard_alloc,
	.tp_new = PyType_GenericNew,
	.tp_methods = board_methods,
	.tp_init = Board_init,
	.tp_getset = Board_getset,
	.tp_richcompare = PyBoard_compare,
	.tp_as_mapping = &PyBoardAsMap,
	.tp_repr = (reprfunc)PyBoard_repr,
	.tp_hash = PyBoard_hash
};

/* UTILS */


static PyObject *
PyUtils_count_moves(PyObject *self, PyObject *args){
	if (!PyTypeCheck("Board", args, &PyBoardType)) return NULL;
	u_int8_t count = count_legal_moves(PyBoard_board(args));		
	return PyLong_FromUnsignedLong(count);
}


static PyObject *PyUtils_is_quiescent(PyObject *self, PyObject *args){
	if (!PyTypeCheck("Board", args, &PyBoardType)) return NULL;
	return is_quiescent(PyBoard_board(args)) ? Py_True : Py_False;
}

static PyObject *PyUtils_perft(PyObject *self, PyObject *args){
	PyObject *board;
	u_int8_t depth;	
	if (!PyArg_ParseTuple(args, "Ob", &board, &depth)) {
		return NULL; 
	}
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL;
	return PyLong_FromLongLong(perft(PyBoard_board(board), depth));
}

static PyObject *PyUtils_srandom(PyObject *self, PyObject *arg){
	if (Py_IsNone(arg)) {
		initstate(time(NULL), rand_state, 256);
		Py_RETURN_NONE;
	}
	
	if (!PyTypeCheck("int", arg, &PyLong_Type)) return NULL;
	unsigned long seed = PyLong_AsUnsignedLong(arg);	
	initstate(seed, rand_state, 256);
	Py_RETURN_NONE;
}

#define UTIL_FROM_BOARD_TO_BB(func) static PyObject *PyUtils_ ## func \
	(PyObject *self, PyObject *args){ \
		if (!PyTypeCheck("Board", args, &PyBoardType)) return NULL; \
		return (PyObject *)PyBitboard_make(func(PyBoard_board(args))); \
	}


UTIL_FROM_BOARD_TO_BB(isolated_pawns)
UTIL_FROM_BOARD_TO_BB(backwards_pawns)
UTIL_FROM_BOARD_TO_BB(doubled_pawns)


static PyMethodDef PyUtilsMethods[] = {
	{"backwards_pawns", PyUtils_backwards_pawns, METH_O, NULL},	
	{"isolated_pawns", PyUtils_isolated_pawns, METH_O, NULL},	
	{"doubled_pawns", PyUtils_doubled_pawns, METH_O, NULL},	
	{"count_moves", PyUtils_count_moves, METH_O, NULL},	
	{"is_quiescent", PyUtils_is_quiescent, METH_O, NULL},	
	{"perft", PyUtils_perft,  METH_VARARGS, NULL},	
	{"set_random_seed", PyUtils_srandom, METH_O, NULL},
	{NULL, NULL, 0, NULL}
};



/* PGN */

typedef struct {
	PyObject_HEAD
	u_int8_t result;	
} PyPGNResultObject;

static PyTypeObject PyPGNResultType;

static PyPGNResultObject *PyResults[4] = {0};

static bool PyPGNResults_init(){
	for (u_int8_t res = DRAW_RES; res <= UNK_RES; res++) {
		if (PyResults[res]) return true;
		PyPGNResultObject *obj = PyObject_NEW(PyPGNResultObject, &PyPGNResultType); 
		if (!obj){
		 	for (u_int8_t res2 = DRAW_RES; res2 < res; res2++) {
				PyGeneric_Dealloc((PyObject*)PyResults[res2]);
			}
			return false;
		}
		PyResults[res] = obj;
		obj->result = res;
	}
	return true;
}

static PyObject* PyPGNResult_make(u_int8_t res) {
	return (PyObject *)PyResults[res];
}

#define RESULT_TO_OBJ(field, draw, white, black, unk, wrapper)\
static PyObject* PyPGNResult_ ## field (PyObject *self) {\
	PyPGNResultObject *obj = (PyPGNResultObject *)self; \
	switch (obj->result) { \
		case DRAW_RES: return (PyObject *)wrapper(draw);\
		case WHITE_RES: return (PyObject *)wrapper(white);\
		case BLACK_RES: return (PyObject *)wrapper(black);\
		default: return (PyObject *)unk;\
	}\
}\


RESULT_TO_OBJ(winner, Py_None, WhiteObject, BlackObject, Py_None,)
RESULT_TO_OBJ(unknown, Py_False, Py_False, Py_False, Py_True, )
RESULT_TO_OBJ(draw, Py_True, Py_False, Py_False, Py_False, )
RESULT_TO_OBJ(to_str, "1/2-1/2", "1-0", "0-1", "*", PyUnicode_FromString)

#define MAKE_RES_GETTER_ENTRY(field) {#field , (getter)PyPGNResult_ ## field, NULL, NULL}

static PyGetSetDef PyPGNResult_getset[] = {
	MAKE_RES_GETTER_ENTRY(winner),	
	MAKE_RES_GETTER_ENTRY(unknown),	
	MAKE_RES_GETTER_ENTRY(draw),
	{NULL}
};


static PyTypeObject PyPGNResultType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.pgn.PGNResult",
	.tp_basicsize = sizeof(PyPGNResultObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PyPGNResult_to_str,	
	.tp_getset = PyPGNResult_getset,
};




typedef struct {
	PyObject_HEAD
		pgn_game_t *game;
} PyPGNGameObject;

static PyTypeObject PyPGNGameType;

#define pgn_validate(ptr) if (!ptr) {\
	PyErr_SetString(PyExc_MemoryError, \
			"Could not allocate new PGNGame");\
	return NULL;}\

static PyObject *PyPGNGame_Alloc() {
	PyPGNGameObject *obj = PyObject_New(PyPGNGameObject, &PyPGNGameType);
	pgn_validate(obj);
	obj->game = PyMem_RawMalloc(sizeof(pgn_game_t));
	pgn_validate(obj->game);
	obj->game->moves = PyMem_RawMalloc(600 * sizeof(move_t));
	pgn_validate(obj->game->moves);
	pgn_tag_section_t *tags = PyMem_RawMalloc(sizeof(pgn_tag_section_t));
	pgn_validate(tags);
	tags->event = PyMem_RawMalloc(255);
	tags->site= PyMem_RawMalloc(255);
	tags->round = PyMem_RawMalloc(255);
	tags->white_player = PyMem_RawMalloc(255);
	tags->black_player = PyMem_RawMalloc(255);
	obj->game->tags = tags;
	obj->game->starting_board = PyMem_RawMalloc(sizeof(full_board_t));
	obj->game->starting_board->position = PyMem_RawMalloc(sizeof(position_t));
	return (PyObject *)obj;
}


static void PyPGNGame_Dealloc(PyObject *self){
	PyPGNGameObject *game = (PyPGNGameObject *)self;
	
	pgn_tag_section_t *tags = game->game->tags;
	PyMem_RawFree(tags->event);
	PyMem_RawFree(tags->site);

	PyMem_RawFree(tags->round);
	PyMem_RawFree(tags->white_player);
	PyMem_RawFree(tags->black_player);

	PyMem_RawFree(tags);
	PyMem_RawFree(game->game->moves);
	PyMem_RawFree(game->game);
	PyGeneric_Dealloc(self);
}	

#define PGN_MAKE_GETTER(field,to_py_obj) static PyObject *PyPGN_ ## field (PyObject *self, void *closure){\
	PyPGNGameObject *game = (PyPGNGameObject *)self;\
	PyObject *obj = to_py_obj(game->game->tags->field);\
	if (!obj){ return NULL; } return obj;}


#define DATE_TUPLE_SET(index, known, val) if (known)\
	PyTuple_SET_ITEM(tuple, index, PyLong_FromUnsignedLong(val));\
	else {\
		PyTuple_SET_ITEM(tuple, index, Py_None);\
	}\

static PyObject *PyObject_from_date(date_t date) {
	PyObject *tuple = PyTuple_New(3);
	if (!tuple) return NULL;
	DATE_TUPLE_SET(0, date.known_year, date.year);	
	DATE_TUPLE_SET(1, date.known_month, date.month);	
	DATE_TUPLE_SET(2, date.known_day, date.day);	
	return tuple;
}

PGN_MAKE_GETTER(date,PyObject_from_date)
PGN_MAKE_GETTER(event,PyUnicode_FromString)
PGN_MAKE_GETTER(site,PyUnicode_FromString)
PGN_MAKE_GETTER(white_player,PyUnicode_FromString)
PGN_MAKE_GETTER(black_player,PyUnicode_FromString)
PGN_MAKE_GETTER(round,PyUnicode_FromString)
PGN_MAKE_GETTER(result,PyPGNResult_make)

static PyObject *PyPGN_moves(PyObject *self, void *clousre){
	printf("called moves\n");
	PyPGNGameObject *game = (PyPGNGameObject *)self;
	move_t *moves = game->game->moves;
	size_t count = game->game->count;
	PyObject* list = PyList_New(count);
	if (!list){
		PyErr_SetString(PyExc_MemoryError, "Could not allocate moves list");
		return NULL;
	}
	for (int i = 0; i < count; i++) {
		PyMoveObject *move_obj = PyMove_make(moves[i]);
		if (!move_obj){
			for (int j = 0; j < i; j++) {
				Py_DECREF(PyList_GET_ITEM(list, j));
			}
			Py_DECREF(list);
			PyErr_SetString(PyExc_ValueError, "Illegal Move");
			return NULL;
		}
		PyList_SET_ITEM(list, i, move_obj);
	}
	printf("ret list\n");
	return list;
}


#define MAKE_GETTER_ENTRY(field) {#field , (getter)PyPGN_ ## field, NULL, NULL}

static PyGetSetDef PyPGNGame_getset[] = {
		MAKE_GETTER_ENTRY(event),
		MAKE_GETTER_ENTRY(site),
		MAKE_GETTER_ENTRY(date),
		MAKE_GETTER_ENTRY(white_player),
		MAKE_GETTER_ENTRY(black_player),
		MAKE_GETTER_ENTRY(round),
		MAKE_GETTER_ENTRY(result),
		MAKE_GETTER_ENTRY(moves),
		{NULL}
};



static PyTypeObject PyPGNGameType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.pgn.PGNGame",
	.tp_basicsize = sizeof(PyPGNGameObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_dealloc = (destructor)PyPGNGame_Dealloc,	
	.tp_getset = PyPGNGame_getset,
};





typedef struct {
	PyObject_HEAD
	pgn_file_t pgnf;
} PyPGNFileObject;



static PyTypeObject PyPGNFileType;

static PyObject *PyPGNFile_open(PyObject *unused, PyObject *args) {
	if (!PyTypeCheck("str", args, &PyUnicode_Type)) return NULL;
	const char *path = PyUnicode_AsUTF8(args);
	if (!path) return NULL;
	FILE *file = fopen(path, "r");
	if (!file) {
		PyErr_Format(PyExc_FileNotFoundError, 
				"Could not find PGN file with path %s", path);
		return NULL;
	}
	PyPGNFileObject *self = PyObject_New(PyPGNFileObject, &PyPGNFileType);
	if (!self) return NULL;
	self->pgnf.ctx = start_context(path, ";[].*()<>", "\"\"{}", '\\');
	self->pgnf.file = file;	
	return (PyObject *)self;
}

static PyObject *PyPGNFile_close(PyObject *self, PyObject *Py_UNUSED(args)){
	PyPGNFileObject *obj = (PyPGNFileObject *)self; 
	fclose(obj->pgnf.file);	
	end_context(obj->pgnf.ctx);		
	Py_RETURN_NONE;
}

static PyObject *PyPGNFile_read_next_game(PyObject *self, PyObject *Py_UNUSED(args)){
	PyPGNFileObject *obj = (PyPGNFileObject *)self; 
	PyPGNGameObject *game = (PyPGNGameObject *)PyPGNGame_Alloc();
	printf("alloc game done\n");
	if (!game) return NULL;
	char err[500];
	int res = next_pgn(&obj->pgnf, game->game, err);
	printf("got next game\n");
	switch (res) {
		case 0: {
			printf("now\n");
			return (PyObject *)game;
		}
		case 1: {
			printf("ERR!\n");
			Py_DECREF(game);
			PyErr_SetString(PyExc_ValueError, err);
			return NULL;
		}
		case 2: Py_RETURN_NONE;
	}
}



static PyMethodDef PyPGNFile_methods[] = { 
    {"next_game", PyPGNFile_read_next_game, METH_NOARGS, NULL}, 
		{"open", PyPGNFile_open, METH_O | METH_STATIC, NULL},
		{"close", PyPGNFile_close, METH_NOARGS, NULL},
    {NULL, NULL, 0, NULL}
};

static PyTypeObject PyPGNFileType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.pgn.PGNFile",
	.tp_basicsize = sizeof(PyPGNFileObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_dealloc = (destructor)PyGeneric_Dealloc,	
	.tp_methods = PyPGNFile_methods,
	//.tp_init = Board_init,
	//.tp_getset = Board_getset,
	//.tp_richcompare = PyBoard_compare,
	//.tp_as_mapping = &PyBoardAsMap,
	//.tp_repr = (reprfunc)PyBoard_repr,
	//.tp_hash = PyBoard_hash
};



static struct PyModuleDef bulletchess_definition = { 
    PyModuleDef_HEAD_INIT,
    .m_name = "bulletchess._core",
		.m_doc = NULL, 
		.m_size = -1,  
		.m_methods = NULL
};


#define VALIDATE(pt) if (!pt) {Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL;} 
#define ADD_OBJ(name, obj) if (PyModule_AddObjectRef(m, name, \
			(PyObject *)obj) < 0) { Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL; }

#define ADD_UTIL(name, obj) if (PyModule_AddObjectRef(utils, name, \
			(PyObject *)obj) < 0) { Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL; }



#define ADD_TYPE(name, type) if (PyType_Ready(&type) < 0) return NULL; \
	ADD_OBJ(name, &type);



#define ADD_PGN(name, obj) if (PyModule_AddObjectRef(pgn, name, \
			(PyObject *)obj) < 0) { Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL; }




PyMODINIT_FUNC PyInit__core(void) {
		printf("init\n");
    if (PyType_Ready(&PyBoardType) < 0) return NULL;
		if (PyType_Ready(&PyColorType) < 0) return NULL;
		if (PyType_Ready(&PySquareType) < 0) return NULL;
		if (PyType_Ready(&PyPieceTypeType) < 0) return NULL;
		if (PyType_Ready(&PyPieceType) < 0) return NULL;
		if (PyType_Ready(&PyMoveType) < 0) return NULL;
		if (PyType_Ready(&PyBitboardType) < 0) return NULL;
		if (PyType_Ready(&PyPGNFileType) < 0) return NULL;
		if (PyType_Ready(&PyPGNGameType) < 0) return NULL;
		if (PyType_Ready(&PyPGNResultType) < 0) return NULL;
		initstate(time(NULL), rand_state, 256);
		PyObject *m = PyModule_Create(&bulletchess_definition);
		if (!m) return NULL;
		PyObject *utils = PyImport_AddModuleRef("bulletchess.utils");
		if (!utils){ 
			Py_DECREF(utils); 
			return NULL;
		}
		PyObject *pgn = PyImport_AddModuleRef("bulletchess.pgn");
		if (!pgn){
			Py_DECREF(utils);
			Py_DECREF(m);
			return NULL;
		}	
		VALIDATE(PySquares_init());
		VALIDATE(PyPieceTypes_init());
		VALIDATE(PyColors_init());
		VALIDATE(PyPGNResults_init());
		PyModule_AddFunctions(utils, PyUtilsMethods);
		ADD_PGN("PGNGame", &PyPGNGameType);
		ADD_PGN("PGNFile", &PyPGNFileType);
		ADD_PGN("PGNResult", &PyPGNResultType);
		ADD_OBJ("utils", utils);
		ADD_OBJ("Board", &PyBoardType);
		ADD_OBJ("Bitboard", &PyBitboardType);
		ADD_OBJ("Color", &PyColorType);
		ADD_OBJ("Square", &PySquareType);
		ADD_OBJ("PieceType", &PyPieceTypeType);
		ADD_OBJ("Piece", &PyPieceType);
		ADD_OBJ("Move", &PyMoveType);
		PyObject *WHITE = PyColor_make(WHITE_VAL);
		VALIDATE(WHITE);
		PyObject *BLACK = PyColor_make(BLACK_VAL);
		VALIDATE(BLACK);
		ADD_OBJ("WHITE", WHITE);
		ADD_OBJ("BLACK", BLACK);
		PyObject *Squares_List = PyList_New(0);
		for (square_t sq = A1; sq <= H8; sq++) {
			char buffer[3];
			serialize_sqr_caps(sq, buffer);
			PyObject *PySquare = PySquare_make(sq);
			VALIDATE(PySquare);
			ADD_OBJ(buffer, PySquare);
			PyList_Append(Squares_List, PySquare);
		}
		ADD_OBJ("SQUARES", Squares_List);
		PyObject *PAWN = PyPieceType_make(PAWN_VAL);
		VALIDATE(PAWN);	
		PyObject *KNIGHT = PyPieceType_make(KNIGHT_VAL);
		VALIDATE(KNIGHT);
		PyObject *BISHOP = PyPieceType_make(BISHOP_VAL);
		VALIDATE(BISHOP);
		PyObject *ROOK = PyPieceType_make(ROOK_VAL);
		VALIDATE(ROOK);
		PyObject *QUEEN = PyPieceType_make(QUEEN_VAL);
		VALIDATE(QUEEN);
		PyObject *KING = PyPieceType_make(KING_VAL);
		VALIDATE(KING);
		bitboard_t cur_rank = RANK_1;
		for (int rank_num = 1; rank_num < 9; rank_num++) {
			char buffer[7];
			sprintf(buffer, "RANK_%d", rank_num);
			PyObject *RANK = (PyObject *)PyBitboard_make(cur_rank);
			VALIDATE(RANK);
			ADD_OBJ(buffer, RANK);
			cur_rank = SAFE_ABOVE_BB(cur_rank);
		}

		bitboard_t cur_file = FILE_A;
		for (int file_num = 0; file_num < 8; file_num++) {
			char buffer[7];
			sprintf(buffer, "%c_FILE", 'A' + file_num);
			PyObject *FILEV= (PyObject *)PyBitboard_make(cur_file);
			VALIDATE(FILEV);
			ADD_OBJ(buffer, FILEV);
			cur_file= SAFE_RIGHT_BB(cur_file);
		}


		ADD_OBJ("PAWN", PAWN);
		ADD_OBJ("KNIGHT", KNIGHT);
		ADD_OBJ("BISHOP", BISHOP);
		ADD_OBJ("ROOK", ROOK);
		ADD_OBJ("QUEEN", QUEEN);
		ADD_OBJ("KING", KING);
		PyObject * PieceTypes_List = PyList_New(0);
		VALIDATE(PieceTypes_List);
		PyList_Append(PieceTypes_List, PAWN);
		PyList_Append(PieceTypes_List, KNIGHT);
		PyList_Append(PieceTypes_List, BISHOP);
		PyList_Append(PieceTypes_List, ROOK);
		PyList_Append(PieceTypes_List, QUEEN);
		PyList_Append(PieceTypes_List, KING);
		ADD_OBJ("PIECE_TYPES", PieceTypes_List);
		zobrist_table = create_zobrist_table();
		printf("end\n");	
		return m;
}


