#include "include/Python.h"
#include "apply.h" 
#include "fen.h"
#include "rules.h"


static bool PyTypeCheck(char *expected, PyObject *obj, PyTypeObject *type){
		if (!Py_IS_TYPE(obj, type)) {
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
			return false;	
		}
	return true;
}

/* Square CLASS */

typedef struct {
	PyObject_HEAD
	square_t square;
} PySquareObject;

static PyTypeObject PySquareType;

static PyObject *PySquare_make(square_t square) {
	PySquareObject *py_square = 
		PyObject_New(PySquareObject, &PySquareType);
	if (!py_square) return NULL;
	py_square->square = square;
	return (PyObject *)py_square;
}

static inline square_t PySquare_get(PyObject *self) {
	return ((PySquareObject *)self)->square;
}

PyObject *PySquare_compare(PyObject *self, PyObject *other, int op){
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

Py_hash_t PySquare_hash(PyObject *self){
	return PySquare_get(self);
}

PyObject *PySquare_from_optional(optional_square_t opt) {
	if (opt.exists) {
		return PySquare_make(opt.square);
	}
	else Py_RETURN_NONE;
}

PyObject *PySquare_str(PyObject *self) {
	char buffer[3];
	serialize_sqr_caps(PySquare_get(self), buffer);
	return PyUnicode_FromString(buffer);
}

static PyTypeObject PySquareType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Square",
	.tp_basicsize = sizeof(PySquareObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PySquare_str,
	.tp_richcompare = PySquare_compare,
	//.tp_repr = PySquare_str,
	.tp_hash = PySquare_hash
};


/* PieceType CLASS */

typedef struct {
	PyObject_HEAD
	piece_type_t piece_type;
} PyPieceTypeObject;

static PyTypeObject PyPieceTypeType;

static inline piece_type_t PyPieceType_get(PyObject *self){
	return ((PyPieceTypeObject *)self)->piece_type;
}


static PyObject *PyPieceType_make(piece_type_t piece_type) {
	PyPieceTypeObject *py_piece_type = 
		PyObject_New(PyPieceTypeObject, &PyPieceTypeType);
	if (!py_piece_type) return NULL;
	py_piece_type->piece_type = piece_type;	
	return (PyObject *)py_piece_type;
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
	//.tp_repr = PyPieceType_str,
	.tp_hash = PyPieceType_hash
};



/* Color CLASS */

typedef struct {
	PyObject_HEAD
	piece_color_t color;
} PyColorObject; 

static PyTypeObject PyColorType;

static PyObject *PyColor_make(piece_color_t color) {
	PyColorObject *py_color = PyObject_New(PyColorObject, &PyColorType);
	if (!py_color) return NULL;
	py_color->color = color;
	return (PyObject *)py_color;
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
	//.tp_repr = PyColor_str,
	.tp_hash = PyColor_hash
};



/* Piece CLASS */


typedef struct {
	PyObject_HEAD
	piece_t piece;
} PyPieceObject; 


static PyTypeObject PyPieceType;


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
			printf("NO ERR HERE\n");
			return -1;
		}
		if (!PyTypeCheck("Color", color, &PyColorType)) return -1;
		if (!PyTypeCheck("PieceType", piece_type, &PyPieceTypeType)) return -1;
  	piece_t piece = {.type = PyPieceType_get(piece_type), .color = PyColor_get(color)};
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

static PyObject *PyPiece_str(PyObject *self) {
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
	return PyUnicode_FromFormat("Piece<%s, %s>", color, type);
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
	.tp_str = (reprfunc)PyPiece_str,
	.tp_richcompare = PyPiece_compare,
	.tp_hash = PyPiece_hash,
	.tp_getset = PyPiece_getset
};



/* Move CLASS */
typedef struct {
	PyObject_HEAD
	move_t move;	
} PyMoveObject;

static PyTypeObject PyMoveType;

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

static bool PyMove_validate_val(move_t m) {
	char *err = error_from_move(m);
	return !PyRaiseIfErr(err);
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

static PyObject* PyMove_get_destination(PyObject *self, void *closure) {
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
    {   
        "from_uci", PyMove_from_uci, METH_O | METH_STATIC, NULL
		}, 
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
	.tp_hash = PyMove_hash
};



/* Board CLASS */

typedef struct {
	PyObject_HEAD
	full_board_t *board;
	undoable_move_t *move_stack;
	size_t stack_size;
	size_t stack_capacity;
} PyBoardObject;


static PyTypeObject PyBoardType;

static PyBoardObject* PyBoard_alloc() {
	PyBoardObject *self = PyObject_New(PyBoardObject, &PyBoardType);
	if (!self) return NULL;
  self->board = PyMem_Malloc(sizeof(full_board_t));
	if (!self->board) return NULL;
	self->board->position = PyMem_Malloc(sizeof(position_t));
	if (!self->board->position) return NULL;
	self->stack_capacity = 5;
	self->move_stack = PyMem_Malloc(self->stack_capacity * sizeof(undoable_move_t));	
	if (!self->move_stack) return NULL;
	self->stack_size = 0;
	return self;
}

static void PyBoard_dealloc(PyBoardObject *self) {
		PyMem_Free(self->board->position);
		PyMem_Free(self->board);
		PyMem_Free(self->move_stack);
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
		// TODO is this pattern a memory leak?
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

static PyObject *PyBoard_random(PyObject *cls, PyObject *Py_UNUSED(args)){
	PyBoardObject *board = PyBoard_alloc();
	if (!board) return NULL;
	PyBoard_setup_starting((PyObject *)board);
	u_int8_t depth = 1 + (random() % 200);
	move_t moves[256];	
	for (u_int8_t i = 0; i < depth; i++) {
		u_int8_t count = generate_legal_moves(board->board, moves);
		if (!count) {
			return (PyObject *)board;
		}
		u_int8_t index = random() % count;
		if (!PyBoard_apply_struct(board, moves[index])) return NULL;
	}
	return (PyObject *)board;
}

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


static PyObject *
PyBoard_count_moves(PyObject *self, PyObject *Py_UNUSED(args)){
	u_int8_t count = count_legal_moves(PyBoard_board(self));		
	return PyLong_FromUnsignedLong(count);
}

/*

typedef struct {
	PyObject_HEAD
	full_board_t *board;
	undoable_move_t *move_stack;
	size_t stack_size;
	size_t stack_capacity;
} PyBoardObject;
*/

static PyObject *PyBoard_copy(PyObject *self, PyObject *Py_UNUSED(args)){
	PyBoardObject *copy_obj = PyBoard_alloc();
	if (!copy_obj) return NULL;
	full_board_t *copy = copy_obj->board; 
	full_board_t *src = PyBoard_board(self);
	memcpy(copy->position, src->position, sizeof(position_t));  
	copy->fullmove_number = src->fullmove_number;
	copy->halfmove_clock = src->halfmove_clock;
	copy->castling_rights = src->castling_rights;
	copy->en_passant_square = src->en_passant_square;
	copy->turn = src->turn;
	size_t stack_size = ((PyBoardObject *)self)->stack_size;
	size_t stack_capacity= ((PyBoardObject *)self)->stack_capacity;
	undoable_move_t * src_stack = ((PyBoardObject *)self)->move_stack;
	void *new_stack = PyMem_Realloc(copy_obj->move_stack, 
			stack_capacity * sizeof(undoable_move_t));
	if (!new_stack) {
		PyErr_SetString(PyExc_MemoryError, "Could not copy Board, out of memory");
		return NULL;
	}
	else copy_obj->move_stack = new_stack;	
	memcpy(copy_obj->move_stack, src_stack, sizeof(undoable_move_t) * stack_size);
	copy_obj->stack_size = stack_size;
	copy_obj->stack_capacity = stack_capacity;
	return (PyObject *)copy_obj;
}



static bool PyBoard_apply_struct(PyBoardObject *board_obj, move_t move){
	undoable_move_t undo = apply_move(board_obj->board, move);
	if (board_obj->stack_size == board_obj->stack_capacity) {
		size_t new_capacity = board_obj->stack_capacity * 2;
		void *new_ptr = PyMem_Realloc(board_obj->move_stack, sizeof(undoable_move_t) * new_capacity);
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
	
	if (!PyTypeCheck("Square", key, &PySquareType)) return NULL;
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




static PyMethodDef board_methods[] = { 
    {"from_fen", PyBoard_from_fen, METH_O | METH_STATIC, NULL},  
    {"random", PyBoard_random, METH_NOARGS | METH_STATIC, NULL},  
    {"empty", PyBoard_empty, METH_NOARGS | METH_STATIC, NULL},  
		{"fen", PyBoard_to_fen, METH_NOARGS, NULL},
	 	{"legal_moves", PyBoard_legal_moves, METH_NOARGS, NULL},
	 	{"count_moves", PyBoard_count_moves, METH_NOARGS, NULL},	
	 	{"apply", PyBoard_apply, METH_O, NULL},	
	 	{"undo", PyBoard_undo, METH_NOARGS, NULL},	
		{"copy", PyBoard_copy, METH_NOARGS, NULL},
		//{"status", NULL, 0, NULL},
		{NULL, NULL, 0, NULL}
};


static PyObject *PyBoard_ep_square(PyObject *self, void *closure) {
	return PySquare_from_optional(PyBoard_board(self)->en_passant_square);
}

static PyObject *PyBoard_turn_get(PyObject *self, void *closure) {
	return PyColor_make(PyBoard_board(self)->turn);
}

static PyObject *PyBoard_fullmove_get(PyObject *self, void *closure) {
	return PyLong_FromUnsignedLong(PyBoard_board(self)->fullmove_number);
}

static PyObject *PyBoard_halfmove_get(PyObject *self, void *closure) {
	return PyLong_FromUnsignedLong(PyBoard_board(self)->halfmove_clock);
}



static PyGetSetDef Board_getset[] = {
    {"turn", (getter)PyBoard_turn_get, NULL, NULL, NULL},
    {"fullmove_number", (getter)PyBoard_fullmove_get, NULL, NULL, NULL},
    {"halfmove_clock", (getter)PyBoard_halfmove_get, NULL, NULL, NULL},
    {"en_passant_square", (getter)PyBoard_ep_square, NULL, NULL, NULL},
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
	.tp_dealloc = (destructor)PyBoard_dealloc,
	.tp_alloc = (allocfunc)PyBoard_alloc,
	.tp_new = PyType_GenericNew,
	.tp_methods = board_methods,
	.tp_init = Board_init,
	.tp_getset = Board_getset,
	.tp_richcompare = PyBoard_compare,
	.tp_as_mapping = &PyBoardAsMap
};



static struct PyModuleDef bulletchess_definition = { 
    PyModuleDef_HEAD_INIT,
    "bulletchess",
		NULL,
		-1, 
};


#define VALIDATE(pt) if (!pt) {Py_DECREF(m); return NULL;} 
#define ADD_OBJ(name, obj) if (PyModule_AddObjectRef(m, name, \
			(PyObject *)obj) < 0) { Py_DECREF(m); return NULL; }


PyMODINIT_FUNC PyInit_bulletchess(void) {
    if (PyType_Ready(&PyBoardType) < 0) return NULL;
		if (PyType_Ready(&PyColorType) < 0) return NULL;
		if (PyType_Ready(&PySquareType) < 0) return NULL;
		if (PyType_Ready(&PyPieceTypeType) < 0) return NULL;
		if (PyType_Ready(&PyPieceType) < 0) return NULL;
		if (PyType_Ready(&PyMoveType) < 0) return NULL;
		PyObject *m = PyModule_Create(&bulletchess_definition);
		ADD_OBJ("Board", &PyBoardType);
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
		return m;
}


