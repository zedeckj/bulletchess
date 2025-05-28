#include "bulletchess.h"



#define PY_RETURN_BOOL(BOOL) if (BOOL) Py_RETURN_TRUE; else Py_RETURN_FALSE;

static char rand_state[256];
static zobrist_table_t *zobrist_table;


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


static bool PyBoundCheck(char *argname, int val, int min, int max){
	if (val > max) {
		PyErr_Format(PyExc_OverflowError, 
				"%d is out of bounds of %s, max value is %d", 
			val, argname, max);
		return false;
	}
	else if (val < min) {
		PyErr_Format(PyExc_OverflowError, 
				"%d is out of bounds of %s, min value is %d", 
			val, argname, min);
		return false;
	
	}
	return true;

}




static void PyGeneric_Dealloc(PyObject *self){
	Py_TYPE(self)->tp_free((PyObject *)self);
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
				PyGeneric_Dealloc((PyObject *)PySquares[s2]);
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
	PyObject *obj = (PyObject *)PySquares[square];
	Py_INCREF(obj);
	return obj;
}



static PyObject *PySquare_from_str(PyObject *self, PyObject *args){
	if (!PyTypeCheck("str", args, &PyUnicode_Type)) return NULL;
	const char *str = PyUnicode_AsUTF8AndSize(args, NULL);
	if (!str) return NULL;
	if (strlen(str) != 2) {
		PyErr_Format(PyExc_ValueError, "Square string must be two characters (ex. \"B1\"), got '%s'", str);
		return NULL;
	}
	int file;	
	int rank;
	switch (str[0]){
		case 'a': case 'A':
			file = 0;
			break;
		case 'b': case 'B':
			file = 1;
			break;
		case 'c': case 'C':
			file = 2;
			break;
		case 'd': case 'D':
			file = 3;
			break;
		case 'e': case 'E':
			file = 4;
			break;
		case 'f': case 'F':
			file = 5;
			break;
		case 'g': case 'G':
			file = 6;
			break;
		case 'h': case 'H':
			file = 7;
			break;
		default:
			PyErr_Format(PyExc_ValueError, 
					"Expected a valid file indicator [a-hA-H], got %c", str[0]);
			return NULL;
	}	
	if (str[1] >= '1' && str[1] <= '8'){
		rank = str[1] - '1';
	}
	else {
		PyErr_Format(PyExc_ValueError, 
				"Expected a valid rank indicator [1-8], got %c", str[1]);
		return NULL;
	}
	return PySquare_make(file + rank * 8);
}

static inline square_t PySquare_get(PyObject *self) {
	return ((PySquareObject *)self)->square;
}

/*
 *
 *static int PyPGNDate_init(PyObject *self, PyObject *args, PyObject *kwds){
	PyObject *year;
	PyObject *month;
	PyObject *day;
  static char *kwlist[] = {"year", "month", "day", NULL};
	if (!PyArg_ParseTupleAndKeywords(args, kwds, "OOO", kwlist, &year, &month, &day)) 
		return -1;
	date_t date;
	//date_t *date = &(((PyPGNDateObject *)self)->date);
	INIT_DATE_FIELD(year)
	INIT_DATE_FIELD(month)
	INIT_DATE_FIELD(day)
	((PyPGNDateObject *)self)->date = date;	
	return 0;
}
*/



static PyObject *PySquare_around(PyObject *self, PyObject *Py_UNUSED(arg)){ 
	bitboard_t this_bb = SQUARE_TO_BB(PySquare_get(self));
	bitboard_t out_bb = SAFE_ABOVE_BB(this_bb)
	| SAFE_BELOW_BB(this_bb)
	| SAFE_RIGHT_BB(this_bb)
	| SAFE_LEFT_BB(this_bb)
	| SAFE_NW_BB(this_bb)
	| SAFE_NE_BB(this_bb)
	| SAFE_SW_BB(this_bb)
	| SAFE_SE_BB(this_bb);
	return PyBitboard_make(out_bb);	
}

#define PYSQUARE_DIRECTION(NAME, MACRO)\
static PyObject* PySquare_##NAME(PyObject *self, PyObject *args, PyObject *kwds){\
	PyObject *dist = NULL;\
	static char *kwlist[] = {"distance", NULL};\
	if (!PyArg_ParseTupleAndKeywords(args, kwds, "|O", kwlist, &dist)) return NULL;\
	u_int8_t int_dist;\
	if (!dist) int_dist = 1;\
	else {\
		int_dist = PyLong_AsInt(dist);\
		if (PyErr_Occurred()) return NULL;\
		if (!PyBoundCheck("distance", int_dist, 1, 7)) return NULL;\
	}\
	square_t sq = PySquare_get(self);\
	bitboard_t bb = MACRO(SQUARE_TO_BB(sq));\
	for (int i = 1; i < int_dist; i++) bb = MACRO(bb);\
	if (bb) return PySquare_make(unchecked_bb_to_square(bb));\
	else Py_RETURN_NONE;\
}

PYSQUARE_DIRECTION(north, SAFE_ABOVE_BB)
PYSQUARE_DIRECTION(south, SAFE_BELOW_BB)
PYSQUARE_DIRECTION(west, SAFE_RIGHT_BB)
PYSQUARE_DIRECTION(east, SAFE_LEFT_BB)


PYSQUARE_DIRECTION(nw, SAFE_NW_BB)
PYSQUARE_DIRECTION(ne, SAFE_NE_BB)
PYSQUARE_DIRECTION(sw, SAFE_SW_BB)
PYSQUARE_DIRECTION(se, SAFE_SE_BB)



static PyObject *PySquare_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PySquareType) && 
		PySquare_get(self) == PySquare_get(other); 	
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			Py_RETURN_NOTIMPLEMENTED;
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


#define SQ_DIRECT_OBJ(NAME)\
	{#NAME, (PyCFunction)PySquare_##NAME, METH_VARARGS | METH_KEYWORDS, NULL}


static PyObject* PySquare_to_bitboard(PyObject *self, PyObject *Py_UNUSED(arg)) {
	return PyBitboard_make(SQUARE_TO_BB(PySquare_get(self)));		
}


static PyMethodDef PySquare_methods[] = {
	{"bb", PySquare_to_bitboard, METH_NOARGS, NULL},
	{"from_str", PySquare_from_str, METH_STATIC | METH_O, NULL},
	{"adjacent", PySquare_around, METH_NOARGS, NULL},
	SQ_DIRECT_OBJ(nw),	
	SQ_DIRECT_OBJ(nw),	
	SQ_DIRECT_OBJ(sw),	
	SQ_DIRECT_OBJ(ne),	
	SQ_DIRECT_OBJ(se),	
	SQ_DIRECT_OBJ(north),	
	SQ_DIRECT_OBJ(east),	
	SQ_DIRECT_OBJ(south),	
	SQ_DIRECT_OBJ(west),	
	
	
	{NULL, NULL, 0, NULL},
};

static PyTypeObject PySquareType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Square",
	.tp_basicsize = sizeof(PySquareObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PySquare_str,
	.tp_richcompare = PySquare_compare,
	.tp_repr = PySquare_repr,
	.tp_hash = PySquare_hash,
	.tp_methods = PySquare_methods
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
				PyGeneric_Dealloc((PyObject *)PieceTypeObjects[pt2]);
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
	PyObject *obj = (PyObject *)PieceTypeObjects[piece_type - PAWN_VAL];
	Py_INCREF(obj);
	return obj;
}


static PyObject *PyPieceType_repr(PyObject *self){
	piece_type_t pt = PyPieceType_get(self);
	const char *str = get_piece_name(pt);
	if (str){
		return PyUnicode_FromFormat("<PieceType: %s>", str);
	}
	PyErr_Format(PyExc_AttributeError, 
			"Illegal PieceType with value %d", pt);
	return NULL;
}


static bool str_caseless_eq(const char *str1, const char *str2) {
	size_t i;
	for (i = 0; str1[i] && str2[i]; i++) {
		if (tolower(str1[i]) != tolower(str2[i])) return false;
	}
	if (str1[i] != str2[i]) return false;
	return true;
}

static PyObject *PyPieceType_from_str(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("str", arg, &PyUnicode_Type)) return NULL;
	const char *str = PyUnicode_AsUTF8AndSize(arg, NULL);
	if (str_caseless_eq(str, "Pawn")) 
		return PyPieceType_make(PAWN_VAL); 
	if (str_caseless_eq(str, "Knight"))
		return PyPieceType_make(KNIGHT_VAL);
	if (str_caseless_eq(str, "Bishop"))
		return PyPieceType_make(BISHOP_VAL);
	if (str_caseless_eq(str, "Rook"))
		return PyPieceType_make(ROOK_VAL);
	if (str_caseless_eq(str, "Queen"))
		return PyPieceType_make(QUEEN_VAL);
	if (str_caseless_eq(str, "King"))
		return PyPieceType_make(KING_VAL);
	PyErr_Format(PyExc_ValueError, "Unknown PieceType string \"%s\"", str);
	return NULL;
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
			Py_RETURN_NOTIMPLEMENTED;
	}
}


Py_hash_t PyPieceType_hash(PyObject *self) {
	return PyPieceType_get(self);
}


static PyMethodDef PyPieceType_methods[] = {
	{"from_str", PyPieceType_from_str, METH_STATIC | METH_O, NULL},
	{NULL, NULL, 0, NULL}
};

static PyTypeObject PyPieceTypeType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.PieceType",
	.tp_basicsize = sizeof(PyPieceTypeObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PyPieceType_str,
	.tp_richcompare = PyPieceType_compare,
	.tp_repr = PyPieceType_repr,
	.tp_hash = PyPieceType_hash,
	.tp_methods = PyPieceType_methods

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
    PyGeneric_Dealloc((PyObject *) WhiteObject);
		return false;
	}	
	WhiteObject->color = WHITE_VAL;
	BlackObject->color = BLACK_VAL;
	return true;
}
static PyObject *PyColor_make(piece_color_t color) {
	PyObject *out;
	switch (color) {
		case WHITE_VAL: out = (PyObject *)WhiteObject;
		break;
		case BLACK_VAL: out = (PyObject *)BlackObject;
		break;
		default:
			PyErr_SetString(PyExc_ValueError, "Invalid color generated");
			return NULL;
	}
	Py_INCREF(out);
	return out;
}


static PyObject *PyColor_from_str(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("str", arg, &PyUnicode_Type)) return NULL;
	const char *str = PyUnicode_AsUTF8AndSize(arg, NULL);
	if (str_caseless_eq(str, "White")) 
		return PyColor_make(WHITE_VAL); 
	if (str_caseless_eq(str, "Black"))
		return PyColor_make(BLACK_VAL);
	PyErr_Format(PyExc_ValueError, "Unknown Color string \"%s\"", str);
	return NULL;
}

static inline piece_color_t PyColor_get(PyObject *self) {
	return ((PyColorObject *)self)->color;
}

static PyObject *PyColor_repr(PyObject *self) {
	piece_color_t color = PyColor_get(self);
	switch(color) {
		case WHITE_VAL:
			return PyUnicode_FromString("<Color: White>");
		case BLACK_VAL:
			return PyUnicode_FromString("<Color: Black>");
		default:
			PyErr_Format(PyExc_AttributeError, 
					"Illegal Color with value %d", color);
			return NULL;
	}
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

static PyObject *PyColor_invert(PyObject *self){
	PyObject *out;
	switch (PyColor_get(self)) {
		case BLACK_VAL: out = (PyObject *)WhiteObject;
		break;
		case WHITE_VAL: out = (PyObject *)BlackObject;
		break;
		default:
			PyErr_SetString(PyExc_ValueError, "Invalid color generated");
			return NULL;
	}
	Py_INCREF(out);
	return out;
}

static PyObject *PyColor_opposite(PyObject *self, void *closure){
	return PyColor_invert(self);
}


static PyObject *PyColor_compare(PyObject *self, PyObject *other, int op){
	bool eq = Py_IS_TYPE(other, &PyColorType) && PyColor_get(self) == PyColor_get(other); 	
	switch (op) {
		case Py_EQ:
			return eq ? Py_True : Py_False;
		case Py_NE:
			return eq ? Py_False : Py_True;
		default:
			Py_RETURN_NOTIMPLEMENTED;	
	}
}

static Py_hash_t PyColor_hash(PyObject *self) {
	return (PyColor_get(self) + 1);
}

static PyGetSetDef PyColor_getset[] = {
	{"opposite", PyColor_opposite, NULL, NULL, NULL},
	{NULL},
};

static PyNumberMethods PyColor_as_num = {
	.nb_invert = PyColor_invert
};

static PyMethodDef PyColor_methods[] = {
	{"from_str", PyColor_from_str, METH_O | METH_STATIC, NULL},
	{NULL, NULL, 0, NULL}
};

static PyTypeObject PyColorType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Color",
	.tp_basicsize = sizeof(PyColorObject),
  .tp_itemsize = 0,
	.tp_doc = PyDoc_STR("FOO"),
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PyColor_str,
	.tp_richcompare = PyColor_compare,
	.tp_repr = PyColor_repr,
	.tp_hash = PyColor_hash,
	.tp_methods = PyColor_methods,
	.tp_getset = PyColor_getset,
	.tp_as_number = &PyColor_as_num
};



/* Piece CLASS */
typedef struct {
	PyObject_HEAD
	piece_t piece;
} PyPieceObject; 

PyPieceObject *PyPieces[13];

static PyObject *PyPiece_new(piece_t piece){
	if (piece.type == EMPTY_VAL) Py_RETURN_NONE;
	PyPieceObject *py_piece = PyObject_New(PyPieceObject, &PyPieceType);
	if (!py_piece) return NULL;
	py_piece->piece = piece;
	return (PyObject *)py_piece;
}

static bool PyPiece_make_all(){
	for (int i = 0; i < 13; i++){
			PyPieceObject *p = (PyPieceObject *)PyPiece_new(index_to_piece(i));
			if (!p) {
				for (int j = 0; j < i; j++){
					Py_DECREF(PyPieces[j]);
				}
				return false;
			}
			else PyPieces[i] = p;
	}
	return true;	
}



// Returns None if given an EMPTY_VAL piece
static inline PyObject *PyPiece_index_make(piece_index_t piece) {
	PyPieceObject *p = PyPieces[piece];
	Py_INCREF(p);
	return (PyObject *)p;
}

// Returns None if given an EMPTY_VAL piece
static PyObject *PyPiece_make(piece_t piece) {
	PyPieceObject *p = PyPieces[piece_to_index(piece)];
	Py_INCREF(p);
	return (PyObject *)p;
}


static inline piece_t PyPiece_get(PyObject *self) {
	return ((PyPieceObject *)self)->piece;
}

#define BASIC_COMPARE(TYPE)\
	static PyObject * TYPE ##_compare(PyObject *self,\
			PyObject *other, int op){\
		bool eq = Py_IS_TYPE(other, &(TYPE ## Type)) && TYPE ## _get(self) == TYPE ## _get(other);\
		switch (op){\
			case Py_EQ:\
				return eq ? Py_True : Py_False;\
			case Py_NE:\
				return eq ? Py_False : Py_True;\
			default:\
				Py_RETURN_NOTIMPLEMENTED;\
		}\
	}\

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

static PyObject *PyPiece_unicode(PyObject *self, PyObject *Py_UNUSED(arg)){
	char *unicode = piece_unicode(PyPiece_get(self));
	return PyUnicode_FromString(unicode);	
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


static PyObject *PyPiece_str(PyObject *self) {
	piece_t p = PyPiece_get(self);
	return PyUnicode_FromFormat("%c", piece_symbol(p));
}


static PyObject *PyPiece_color_get(PyObject *self, void *closure) {
	return PyColor_make(PyPiece_get(self).color);
}

static PyObject *PyPiece_type_get(PyObject *self, void *closure) {
	return PyPieceType_make(PyPiece_get(self).type);
}


#define MAKE_WHITE(TYPE)\
	PyPiece_index_make(TYPE ## _INDEX)
#define MAKE_BLACK(TYPE)\
	PyPiece_index_make(TYPE ## _INDEX + BLACK_OFFSET)

static PyObject *PyPiece_from_str(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("str", arg, &PyUnicode_Type)) return NULL;
	Py_ssize_t len;
	const char *str = PyUnicode_AsUTF8AndSize(arg, &len);
	if (len != 1) {
		PyErr_Format(PyExc_ValueError, "Expected a string of length 1, got \"%s\"", str);
		return NULL;	
	}
	switch (str[0]){
		case 'P': return MAKE_WHITE(PAWN);	
		case 'N': return MAKE_WHITE(KNIGHT);	
		case 'B': return MAKE_WHITE(BISHOP);	
		case 'R': return MAKE_WHITE(ROOK);	
		case 'Q': return MAKE_WHITE(QUEEN);	
		case 'K': return MAKE_WHITE(KING);	
		case 'p': return MAKE_BLACK(PAWN);	
		case 'n': return MAKE_BLACK(KNIGHT);	
		case 'b': return MAKE_BLACK(BISHOP);	
		case 'r': return MAKE_BLACK(ROOK);	
		case 'q': return MAKE_BLACK(QUEEN);	
		case 'k': return MAKE_BLACK(KING);	
		default:
			PyErr_Format(PyExc_ValueError, "Invalid Piece string \"%s\"", str);
			return NULL;
	}
}
static PyObject *PyPiece_newfunc(PyTypeObject *self, PyObject *args,
		PyObject *kwds){
	PyObject *color;
	PyObject *piece_type;
	if (!PyArg_ParseTuple(args, "OO", &color, &piece_type)) return NULL;
	if (!PyTypeCheck("Color", color, &PyColorType)) return NULL;
	if (!PyTypeCheck("PieceType", piece_type, &PyPieceTypeType)) 
		return NULL;
	piece_t piece = {
			.type = PyPieceType_get(piece_type), 
			.color = PyColor_get(color)
	};
	return PyPiece_make(piece);
}



static PyGetSetDef PyPiece_getset[] = {
    {"color", (getter)PyPiece_color_get, NULL, NULL, NULL},
		{"piece_type", (getter)PyPiece_type_get, NULL, NULL, NULL},
		{NULL}
};

static PyMethodDef PyPiece_methods[] = {
	{"unicode", PyPiece_unicode, METH_NOARGS , NULL},
	{"from_chr", PyPiece_from_str, METH_O | METH_STATIC, NULL},
	{NULL, NULL, 0, NULL}
};


static PyTypeObject PyPieceType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Piece",
	.tp_basicsize = sizeof(PyPieceObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_new = PyPiece_newfunc,
	.tp_repr = PyPiece_repr,
	.tp_str= PyPiece_str,
	.tp_richcompare = PyPiece_compare,
	.tp_hash = PyPiece_hash,
	.tp_getset = PyPiece_getset,
	.tp_dealloc = PyGeneric_Dealloc,
	.tp_methods = PyPiece_methods,
};


/* Castling */

typedef struct {
	PyObject_HEAD
	castling_rights_t castling_type;
} PyCastlingTypeObject;

PyCastlingTypeObject *WhiteKingside;
PyCastlingTypeObject *WhiteQueenside;
PyCastlingTypeObject *BlackKingside;
PyCastlingTypeObject *BlackQueenside;

static PyTypeObject PyCastlingTypeType;

static PyCastlingTypeObject *PyCastlingType_new(castling_rights_t ct){
	PyCastlingTypeObject *self = PyObject_New(PyCastlingTypeObject, &PyCastlingTypeType);
	if (!self) return NULL;
	self->castling_type = ct;
	return self;
}


static PyCastlingTypeObject *PyCastlingType_make(castling_rights_t ct){
	PyCastlingTypeObject *out;
	switch(ct) {
		case WHITE_KINGSIDE:
			out = WhiteKingside; break;
		case WHITE_QUEENSIDE:
			out = WhiteQueenside; break;
		case BLACK_KINGSIDE:
			out = BlackKingside; break;
		case BLACK_QUEENSIDE:
			out = BlackQueenside; break;
		default: 
			PyErr_SetString(PyExc_ValueError, "Invalid CastlingType");
			return NULL;
	}
	Py_INCREF(out);
	return out;
}


static castling_rights_t PyCastlingType_get(PyObject *self){
	return ((PyCastlingTypeObject *)self)->castling_type;
}

BASIC_COMPARE(PyCastlingType)

static Py_hash_t PyCastlingType_hash(PyObject *self) {
	Py_hash_t h = PyCastlingType_get(self);
	// Dont need for this case, since values are 1 - 16
	//if (h == -1) return -2;
	return h;
}



static char *PyCastlingType_name(PyObject *self){
	char *name = NULL;
	switch (PyCastlingType_get(self)) {
		case WHITE_KINGSIDE:
			name = "(WHITE, KINGSIDE)";
			break;
		case BLACK_KINGSIDE:
			name = "(BLACK, KINGSIDE)";
			break;
		case WHITE_QUEENSIDE:
			name = "(WHITE, QUEENSIDE)";
			break;
		case BLACK_QUEENSIDE:
			name = "(BLACK, QUEENSIDE)";
			break;
	}
	return name;
}

static PyObject *PyCastlingType_repr(PyObject *self){
	char *name = PyCastlingType_name(self);
	return PyUnicode_FromFormat("<CastlingType: %s>", name);
}

static PyObject *PyCastlingType_str(PyObject *self){
	char *str = castling_fen(PyCastlingType_get(self));
	return PyUnicode_FromString(str);
}

static PyObject *PyCastlingType_from_chr(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("str", arg, &PyUnicode_Type)) return NULL;
	Py_ssize_t len;
	const char *str = PyUnicode_AsUTF8AndSize(arg, &len);
	if (len != 1) {
		PyErr_Format(PyExc_ValueError, "Expected a string of length 1, got \"%s\"", str);
		return NULL;	
	}
	switch (str[0]){
		case 'K': return (PyObject *)PyCastlingType_make(WHITE_KINGSIDE);	
		case 'Q': return (PyObject *)PyCastlingType_make(WHITE_QUEENSIDE);	
		case 'k': return (PyObject *)PyCastlingType_make(BLACK_KINGSIDE);	
		case 'q': return (PyObject *)PyCastlingType_make(BLACK_QUEENSIDE);	
		default:
			PyErr_Format(PyExc_ValueError, "Invalid CastlingType string \"%s\"", str);
			return NULL;
	}
}


static PyMethodDef PyCastlingType_methods[] = {
	{"from_chr", PyCastlingType_from_chr, METH_O | METH_STATIC, NULL},
	{NULL, NULL, 0, NULL}
};

static PyTypeObject PyCastlingTypeType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.CastlingType",
	.tp_basicsize = sizeof(PyCastlingTypeObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_richcompare = PyCastlingType_compare,
	.tp_dealloc = PyGeneric_Dealloc,
	.tp_hash = PyCastlingType_hash,
	.tp_repr = PyCastlingType_repr,
	.tp_str = PyCastlingType_str,
	.tp_methods = PyCastlingType_methods
};




typedef struct {
	PyObject_HEAD
	castling_rights_t castling_rights;
} PyCastlingRightsObject;


static PyTypeObject PyCastlingRightsType;

static PyCastlingRightsObject *castling_rights[16];

static PyCastlingRightsObject *PyCastlingRights_New(castling_rights_t ct){
	PyCastlingRightsObject *self = PyObject_New(PyCastlingRightsObject, &PyCastlingRightsType);
	if (!self) return NULL;
	self->castling_rights = ct;
	return self;
}


static PyCastlingRightsObject *PyCastlingRights_make(castling_rights_t ct){
	PyCastlingRightsObject *obj = castling_rights[ct];
	Py_INCREF(obj);
	return obj;
}

static bool PyCastlingRights_init(){
	for (castling_rights_t ct = NO_CASTLING; ct <= FULL_CASTLING; ct++) {
		PyCastlingRightsObject *obj = PyCastlingRights_New(ct);
		if (!obj){
			for (castling_rights_t ct2 = NO_CASTLING; ct2 < ct; ct2++) {
				PyGeneric_Dealloc((PyObject *)castling_rights[ct2]);	
			}
			return false;
		}
		castling_rights[ct] = obj;
	}
	return true;
}

static castling_rights_t PyCastlingRights_get(PyObject *self){
	return ((PyCastlingRightsObject *)self)->castling_rights;
}


static inline bool castling_lte(castling_rights_t c1, castling_rights_t c2){
	#define lt_bit(mask) (~(c1 & mask) | (c2 & mask))
	return lt_bit(WHITE_KINGSIDE)
				&& lt_bit(WHITE_QUEENSIDE)
				&& lt_bit(BLACK_KINGSIDE)
				&& lt_bit(BLACK_QUEENSIDE);
	#undef lt_bit
}


static PyObject * PyCastlingRights_compare(PyObject *self,\
			PyObject *other, int op){
	#define castle_check\
		if (!Py_IS_TYPE(other, &PyCastlingRightsType))\
			Py_RETURN_NOTIMPLEMENTED; 
	switch (op){
			case Py_EQ:
				PY_RETURN_BOOL(self == other);
			case Py_NE:
				PY_RETURN_BOOL(self != other);
			case Py_LT: {
				castle_check
				PY_RETURN_BOOL(self != other && 
						castling_lte(PyCastlingRights_get(self), 
						PyCastlingRights_get(other)))
			}
			case Py_LE: {
				castle_check
				PY_RETURN_BOOL(castling_lte(PyCastlingRights_get(self), 
						PyCastlingRights_get(other)))
			}
			case Py_GT: {
				castle_check
				PY_RETURN_BOOL(self != other && 
						castling_lte(PyCastlingRights_get(other), 
						PyCastlingRights_get(self)))
			}
			case Py_GE: {
				castle_check
				PY_RETURN_BOOL(castling_lte(PyCastlingRights_get(self), 
						PyCastlingRights_get(other)))
			}		
			default:
				Py_RETURN_NOTIMPLEMENTED;
	}
}

static Py_hash_t PyCastlingRights_hash(PyObject *self) {
	Py_hash_t h = PyCastlingRights_get(self);
	// Dont need for this case, since values are 1 - 16
	//if (h == -1) return -2;
	return h;
}


/*
static char *PyCastlingRights_name(PyObject *self){
	char *name; 
	switch (PyCastlingType_get(self)) {
		case WHITE_KINGSIDE:
			name = "(WHITE, KINGSIDE)";
			break;
		case BLACK_KINGSIDE:
			name = "(BLACK, KINGSIDE)";
			break;
		case WHITE_QUEENSIDE:
			name = "(WHITE, QUEENSIDE)";
			break;
		case BLACK_QUEENSIDE:
			name = "(BLACK, QUEENSIDE)";
			break;
	}
	return name;
}
*/

static PyObject *PyCastlingRights_add(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("CastlingRights", arg, &PyCastlingRightsType)) return NULL;
	castling_rights_t right = PyCastlingRights_get(self);
	castling_rights_t left = PyCastlingRights_get(arg);
	return (PyObject *)PyCastlingRights_make(right | left);	
}

static PyObject *PyCastlingRights_from_fen(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("str", arg, &PyUnicode_Type)) return NULL;
	const char *fen = PyUnicode_AsUTF8(arg);
	castling_rights_t cr;
	char *err = parse_castling(fen, &cr);
	if (err){
		PyErr_SetString(PyExc_ValueError, err);
		return NULL;
	}	
	return (PyObject *)PyCastlingRights_make(cr);
}

static PyObject *PyCastlingRights_repr(PyObject *self){
	char *str = castling_fen(PyCastlingRights_get(self));
	return PyUnicode_FromFormat("<CastlingRights: \"%s\">", str);
}

static PyObject *PyCastlingRights_str(PyObject *self){
	char *str = castling_fen(PyCastlingRights_get(self));
	return PyUnicode_FromString(str);
}


static PyObject *PyCastlingRights_fen(PyObject *self, PyObject *
		Py_UNUSED(arg)){
	char *str = castling_fen(PyCastlingRights_get(self));
	return PyUnicode_FromString(str);
}



static PyObject*
PyCastlingRights_newfunc(PyTypeObject *self, PyObject *args, PyObject *kwds){
		PyObject *castling_types;
		if (!PyArg_ParseTuple(args, "O", &castling_types)) return NULL;
		//if (!PyTypeCheck("set", square_set, &PySet_Type)) return -1;
		PyObject *iter;
		if (!(iter = PyObject_GetIter(castling_types))) {
			PyTypeErr("Iterable", castling_types);
			return NULL;
		}
		PyObject *next;
		castling_rights_t cr = NO_CASTLING;
		while ((next = PyIter_Next(iter))){
			if (!PyTypeCheck("CastlingType", next, &PyCastlingTypeType)){		
				Py_DECREF(next);	
				return NULL;
			}
			cr |= PyCastlingType_get(next);
			Py_DECREF(next);	
		}
		Py_DECREF(iter);
		return (PyObject *)PyCastlingRights_make(cr);
}


#define PY_BOOL(C_EXPR) C_EXPR ? Py_True : Py_False

static int PyCastlingRights_contains(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("CastlingType", arg, &PyCastlingTypeType)) return -1;
	castling_rights_t check = PyCastlingType_get(arg);
	return check & PyCastlingRights_get(self) ? 1 : 0;
}


static PyObject* PyCastlingRights_full(PyObject* self, PyObject *args){
	castling_rights_t cr = PyCastlingRights_get(self);
	PyObject *arg = NULL;
	if (!PyArg_ParseTuple(args, "|O", &arg)) return NULL;
	if (!arg || Py_IsNone(arg)) 
		return PY_BOOL(cr == FULL_CASTLING);	
	if (!PyTypeCheck("Color or None", arg, &PyColorType)) return NULL;
	switch (PyColor_get(arg)){
		case WHITE_VAL:
			return PY_BOOL((cr & WHITE_FULL_CASTLING) 
					== WHITE_FULL_CASTLING);
		default:
			return PY_BOOL((cr & BLACK_FULL_CASTLING)	
					== BLACK_FULL_CASTLING);
	}
}

static PyObject* PyCastlingRights_any(PyObject* self, PyObject *args){
	castling_rights_t cr = PyCastlingRights_get(self);
	PyObject *arg = NULL;
	if (!PyArg_ParseTuple(args, "|O", &arg)) return NULL;
	if (!arg || Py_IsNone(arg)) 
		return PY_BOOL(cr);	
	if (!PyTypeCheck("Color or None", arg, &PyColorType)) return NULL;
	switch (PyColor_get(arg)){
		case WHITE_VAL:
			return PY_BOOL((cr & WHITE_FULL_CASTLING));
		default:
			return PY_BOOL((cr & BLACK_FULL_CASTLING));
	}
}


static PyObject* PyCastlingRights_queenside(PyObject* self, PyObject *args){
	castling_rights_t cr = PyCastlingRights_get(self);
	PyObject *arg = NULL;
	if (!PyArg_ParseTuple(args, "|O", &arg)) return NULL;
	if (!arg || Py_IsNone(arg)) 
		return PY_BOOL(cr & ANY_QUEENSIDE);	
	if (!PyTypeCheck("Color or None", arg, &PyColorType)) return NULL;
	switch (PyColor_get(arg)){
		case WHITE_VAL:
			return PY_BOOL((cr & WHITE_QUEENSIDE));
		default:
			return PY_BOOL((cr & BLACK_QUEENSIDE));
	}
}

static PyObject* PyCastlingRights_kingside(PyObject* self, PyObject *args){
	castling_rights_t cr = PyCastlingRights_get(self);
	PyObject *arg = NULL;
	if (!PyArg_ParseTuple(args, "|O", &arg)) return NULL;
	if (!arg || Py_IsNone(arg)) 
		return PY_BOOL(cr & ANY_KINGSIDE);	
	if (!PyTypeCheck("Color or None", arg, &PyColorType)) return NULL;
	switch (PyColor_get(arg)){
		case WHITE_VAL:
			return PY_BOOL((cr & WHITE_KINGSIDE));
		default:
			return PY_BOOL((cr & BLACK_KINGSIDE));
	}
}

static Py_ssize_t PyCastlingRights_len(PyObject *self){
	return count_bits(PyCastlingRights_get(self));
}

static PyObject *PyCastlingRights_iter(PyObject *self) {
	castling_rights_t src = PyCastlingRights_get(self);
	u_int8_t len = count_bits(src);
	PyObject *list = PyList_New(len);
	u_int8_t i = 0;	
	forbitboard(bit, src){
		PyList_SET_ITEM(list, i++, PyCastlingType_make(bit));
	}
	PyObject *iter = PyObject_GetIter(list);
	Py_DECREF(list);
	return iter;
}



static PyMethodDef PyCastlingRights_methods[] = { 
		{"from_fen", PyCastlingRights_from_fen, METH_STATIC | METH_O, NULL},
		{"any", PyCastlingRights_any, METH_VARARGS, NULL}, 
		{"any", PyCastlingRights_any, METH_VARARGS, NULL}, 
		{"fen", PyCastlingRights_fen, METH_NOARGS, NULL}, 
		{"full", PyCastlingRights_full, METH_VARARGS, NULL}, 
		{"queenside", PyCastlingRights_queenside, METH_VARARGS, NULL}, 
		{"kingside", PyCastlingRights_kingside, METH_VARARGS, NULL}, 
		{NULL, NULL, 0, NULL}

};

static int PyCastlingRights_as_bool(PyObject *self){
	return PyCastlingRights_get(self) ? 1 : 0;
}

static PyNumberMethods PyCastlingRightsAsNum = {
	.nb_add = PyCastlingRights_add,
	.nb_bool = PyCastlingRights_as_bool
};

static PySequenceMethods PyCastlingRightsAsSeq = {
	.sq_contains = PyCastlingRights_contains,
	.sq_length = PyCastlingRights_len
};



static PyTypeObject PyCastlingRightsType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.CastlingRights",
	.tp_basicsize = sizeof(PyCastlingRightsObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_richcompare = PyCastlingRights_compare,
	.tp_dealloc = PyGeneric_Dealloc,
	.tp_hash = PyCastlingRights_hash,
	.tp_repr = PyCastlingRights_repr,
	.tp_str = PyCastlingRights_str,
	.tp_new = PyCastlingRights_newfunc,
	.tp_as_sequence = &PyCastlingRightsAsSeq,
	.tp_methods = PyCastlingRights_methods,
	.tp_as_number = &PyCastlingRightsAsNum,
	.tp_iter = PyCastlingRights_iter
};



/* Move CLASS */
typedef struct {
	PyObject_HEAD
	move_t move;	
} PyMoveObject;


PyMoveObject *generic_moves[64][64];

static void PyMoves_prep() {
	for (int i = 0; i < 64; i++) {
		for (int j = 0; j < 64; j++) {
			generic_moves[i][j] = 0;
		}
	}
}

static PyObject* PyMove_new(move_t move) {
	PyMoveObject *self = PyObject_New(PyMoveObject, &PyMoveType);
	if (!self) return NULL;
	self->move = move;
	return (PyObject*)self;
}

static PyObject* PyMove_make(move_t move) {
	switch (move.type) {
		case GENERIC_MOVE: {
			square_t origin = get_origin(move);
			square_t dest = get_destination(move);
			PyObject *obj = (PyObject *)generic_moves[origin][dest];
			if (obj) {
				Py_INCREF(obj);	
				return obj;
			}
			else {
				obj = PyMove_new(move);
				Py_INCREF(obj);
				generic_moves[origin][dest] = (PyMoveObject *)obj;
				return obj;
			}
		}
		default:
			return PyMove_new(move);
	}
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
			return PyMove_make(move);
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


static PyObject *PyMove_castle(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("CastlingType", arg, &PyCastlingTypeType)) return NULL;	
	switch (PyCastlingType_get(arg)){
		case WHITE_KINGSIDE:
			return PyMove_make(generic_move(move_body(E1, G1)));		
		case WHITE_QUEENSIDE:
			return PyMove_make(generic_move(move_body(E1, C1)));		
		case BLACK_KINGSIDE:
			return PyMove_make(generic_move(move_body(E8, G8)));		
		case BLACK_QUEENSIDE:
			return PyMove_make(generic_move(move_body(E8, C8)));		
		default:
			PyErr_SetString(PyExc_ValueError, "Invalid CastlingType");
			return NULL;
	}
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
	const char *san = PyUnicode_AsUTF8(san_obj);
	bool err = false;
	char err_msg[300];
	move_t move = san_str_to_move(PyBoard_board(board), 
			san, &err, err_msg);
	if (err) {
		PyErr_Format(PyExc_ValueError, "%s for %R, got \"%s\"", err_msg, board, san);
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



#define KING_ROOK(COLOR_OC, ORIGIN, DEST)\
	(SQUARE_TO_BB(ORIGIN) & pos->kings && SQUARE_TO_BB(ORIGIN) & pos->COLOR_OC\
	 && SQUARE_TO_BB(DEST) & pos->rooks && SQUARE_TO_BB(DEST) & pos->COLOR_OC)



static PyObject *PyMove_is_castling(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	move_t move = PyMove_get(self);
	square_t origin = get_origin(move);
	square_t dest = get_destination(move);
	position_t *pos = PyBoard_board(arg)->position;
	switch (origin) {
		case E1:
			switch (dest) {
				case C1: PY_RETURN_BOOL(KING_ROOK(white_oc, E1, A1));
				case G1: PY_RETURN_BOOL(KING_ROOK(white_oc, E1, H1));
				default: Py_RETURN_NONE;
			}			
		case E8:
			switch (dest) {
				case C8: PY_RETURN_BOOL(KING_ROOK(black_oc, E8, A8));
				case G8: PY_RETURN_BOOL(KING_ROOK(black_oc, E8, H8));
				default: Py_RETURN_NONE;
			}
		default: Py_RETURN_NONE;
	}
}

#define RETURN_OPT_CASTLE(BOOL, CASTLE)\
	if (BOOL){Py_INCREF((PyObject *)CASTLE); return (PyObject *)CASTLE;} else Py_RETURN_NONE;

static PyObject *PyMove_get_castling(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	move_t move = PyMove_get(self);
	square_t origin = get_origin(move);
	square_t dest = get_destination(move);
	position_t *pos = PyBoard_board(arg)->position;
	switch (origin) {
		case E1:
			switch (dest) {
				case C1: RETURN_OPT_CASTLE(KING_ROOK(white_oc, E1, A1), WhiteQueenside)
				case G1: RETURN_OPT_CASTLE(KING_ROOK(white_oc, E1, H1), WhiteKingside);
				default: Py_RETURN_NONE;
			}			
		case E8:
			switch (dest) {
				case C8: RETURN_OPT_CASTLE(KING_ROOK(black_oc, E8, A8), BlackQueenside);
				case G8: RETURN_OPT_CASTLE(KING_ROOK(black_oc, E8, H8), BlackKingside);
				default: Py_RETURN_NONE;
			}
		default: Py_RETURN_NONE;
	}
}


static PyObject *PyMove_str(PyObject *self) {
	return PyMove_to_uci(self, NULL);
}


static PyObject *PyMove_is_capture(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	PY_RETURN_BOOL(is_capture(PyBoard_board(arg), PyMove_get(self)));
}


static PyObject *
PyMove_newfunc(PyTypeObject *self, PyObject *args, PyObject *kwargs){
		PyObject *origin;
		PyObject *destination;
		PyObject *promote_to = NULL;
    static char *kwlist[] = {"origin", "destination", "promote_to", NULL};
		if (!PyArg_ParseTupleAndKeywords(args, kwargs, "OO|O", kwlist, &origin, &destination, &promote_to))
			return NULL;
		if (!PyTypeCheck("origin Square", origin, &PySquareType)) 
			return NULL;
		if (!PyTypeCheck("destination Square", destination, &PySquareType))
			return NULL;
		if (promote_to && !Py_IS_TYPE(promote_to, &PyPieceTypeType) && !Py_IsNone(promote_to)) {
			PyTypeErr("PieceType or None", promote_to);
			return NULL;
		}
		square_t origin_v = PySquare_get(origin);
		square_t dest_v = PySquare_get(destination);
		piece_type_t type_v = promote_to && !Py_IsNone(promote_to) ? PyPieceType_get(promote_to) : EMPTY_VAL;
		move_t move = make_move_from_parts(origin_v, dest_v, type_v); 
		if (PyMove_validate_val(move)){
			return PyMove_make(move);
		}
		return NULL;
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


static PyObject *PyMove_is_promotion(PyObject *self, PyObject * args) {
	return get_promotes_to(PyMove_get(self)) == EMPTY_VAL ?
		Py_False : Py_True;
}


static PyMethodDef PyMove_methods[] = { 
    {"castle", PyMove_castle, METH_O | METH_STATIC, NULL}, 
		{"from_uci", PyMove_from_uci, METH_O | METH_STATIC, NULL}, 
    {"from_san", PyMove_from_san, METH_VARARGS | METH_STATIC, NULL}, 
		{"san", PyMove_to_san, METH_O, NULL}, 
		{"uci", PyMove_to_uci, METH_NOARGS, NULL}, 
		{"is_promotion", PyMove_is_promotion, METH_NOARGS, NULL}, 
		{"is_castling", PyMove_is_castling, METH_O, NULL},
		{"is_capture", PyMove_is_capture, METH_O, NULL}, 
		{"castling_type", PyMove_get_castling, METH_O, NULL}, 
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
  .tp_new = PyMove_newfunc,
	.tp_methods = PyMove_methods,
	.tp_getset = PyMove_getset,
	.tp_richcompare = PyMove_compare,
	.tp_hash = PyMove_hash,
	.tp_dealloc = PyGeneric_Dealloc,
	.tp_repr = PyMove_repr,
	.tp_str = PyMove_str,
};


/* Bitboard Class */

typedef struct {
	PyObject_HEAD
	bitboard_t bitboard;
} PyBitboardObject;

static PyTypeObject PyBitboardType;


static PyObject *PyBitboard_make(bitboard_t bitboard){
	PyBitboardObject *self = PyObject_New(PyBitboardObject, &PyBitboardType);
	if (!self) return NULL;
	self->bitboard = bitboard;
	return (PyObject *)self;
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
	return PyLong_FromUnsignedLongLong(bb);
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
	PyObject *iter = PyObject_GetIter(list);
	Py_DECREF(list);
	return iter;
}


static PyObject *PyBitboard_repr(PyObject *self){
	bitboard_t bb = PyBitboard_get(self);
	return PyUnicode_FromFormat("<Bitboard: 0x%llX>", bb);
}

static PyObject *PyBitboard_to_str(PyObject *self){
	char buffer[200];
	str_write_bitboard(PyBitboard_get(self), buffer);
	return PyUnicode_FromString(buffer);
}


static PyObject *PyBitboard_from_int(PyObject *cls, PyObject *arg){ 
	if (!PyTypeCheck("int", arg, &PyLong_Type)) return NULL;
	bitboard_t bb = PyLong_AsUnsignedLongLong(arg);
	if (bb == -1 && PyErr_Occurred()) return NULL;
	return (PyObject *)PyBitboard_make(bb);	
}

static Py_hash_t PyBitboard_hash(PyObject *self){
	Py_hash_t out = PyBitboard_get(self) ;
	return out == -1 ? -2 : out; 
}

static PyObject *PyBitboard_empty(PyObject *cls, PyObject *Py_UNUSED(args)){
	return (PyObject *)PyBitboard_make(0);
}

static PyObject *PyBitboard_all(PyObject *cls, PyObject *Py_UNUSED(args)){
	return (PyObject *)PyBitboard_make(FULL_BB);
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
	.tp_str = PyBitboard_to_str,
	.tp_dealloc = PyGeneric_Dealloc,
	.tp_hash = PyBitboard_hash
};



typedef struct {
	PyObject_HEAD
	u_int8_t text_color;
	u_int8_t light_color;
	u_int8_t dark_color;
	u_int8_t select_color;
} PyColorSchemeObject;


static PyTypeObject PyColorSchemeType;

static PyObject *PyColorScheme_make(
		int text_color, int light_color, int dark_color, int select_color){
	PyColorSchemeObject *self = PyObject_New(PyColorSchemeObject, &PyColorSchemeType);
	if (!self) return NULL;
	self->text_color = text_color;
	self->light_color = light_color;
	self->dark_color = dark_color;
	self->select_color = select_color;
	return (PyObject *)self;
}	
static int PyColorScheme_init(PyObject *self, PyObject *args, PyObject *kwargs){
  PyColorSchemeObject *col = (PyColorSchemeObject *)self;
	col->text_color = 0;
	static char *kwlist[] = {
		"light_square_color", 
		"dark_square_color", 
	 	"highlight_color",	
		"piece_color",
		NULL};
	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "bbb|b", 
				kwlist, &col->light_color, &col->dark_color, 
				&col->select_color, &col->text_color)) 
		return -1;
	return 0;
}


PyObject *OAK = NULL;
PyObject *LAGOON = NULL;
PyObject *SLATE = NULL;
PyObject *GREEN = NULL;
PyObject* WALNUT = NULL;
PyObject* CLAY = NULL;
PyObject* ROSE = NULL;
PyObject* STEEL = NULL;
#define DEFINE_COLOR(NAME, ...)\
	NAME = PyColorScheme_make(__VA_ARGS__);\
	if (!NAME) goto err

static bool PyColorScheme_predefined(){
	DEFINE_COLOR(LAGOON, 0, 117, 33, 195);
	DEFINE_COLOR(SLATE, 0,251 ,103, 231);
	DEFINE_COLOR(OAK,0, 222, 172, 228); 
	DEFINE_COLOR(GREEN, 0, 230, 64, 226);
	DEFINE_COLOR(WALNUT, 0, 230, 137, 226);
	DEFINE_COLOR(CLAY, 0, 251, 138, 222);
	DEFINE_COLOR(ROSE, 0, 224, 197, 189);
	DEFINE_COLOR(STEEL, 0, 251, 243, 231);
	return true;
	err:
	Py_XDECREF(LAGOON);
	Py_XDECREF(SLATE);
	Py_XDECREF(OAK);
	Py_XDECREF(GREEN);
	Py_XDECREF(WALNUT);
	Py_XDECREF(CLAY);
	Py_XDECREF(ROSE);
	Py_XDECREF(STEEL);
	return false;
}


static PyObject *PyColorScheme_repr(PyObject *self){
	PyColorSchemeObject *col = (PyColorSchemeObject *)self;
	return PyUnicode_FromFormat("<ColorScheme: (%d, %d, %d, %d)>",
		 col->light_color, col->dark_color, col->select_color, col->text_color);
}

#define COLOR_SCHEME_GET(OUTNAME,NAME)\
static PyObject *PyColorScheme_##OUTNAME(PyObject *self, void *closure){\
	PyColorSchemeObject *cs = (PyColorSchemeObject *)self;\
	return PyLong_FromLong(cs->NAME);\
}\

COLOR_SCHEME_GET(light_square_color,light_color) 
COLOR_SCHEME_GET(dark_square_color, dark_color) 
COLOR_SCHEME_GET(text_color,text_color) 
COLOR_SCHEME_GET(highlight_color, select_color) 
#define CS_GET_OBJ(NAME)\
	{#NAME, PyColorScheme_##NAME, NULL, NULL}

static PyGetSetDef PyColorSchemeGetDefs[] = {
	CS_GET_OBJ(light_square_color),	
	CS_GET_OBJ(dark_square_color),	
	CS_GET_OBJ(highlight_color),	
	CS_GET_OBJ(text_color),	
  NULL
};

static PyTypeObject PyColorSchemeType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Board.ColorScheme",
	.tp_basicsize = sizeof(PyColorSchemeObject),
  .tp_itemsize = 0,
  //.tp_flags = Py_TPFLAGS_DEFAULT, 
	//.tp_new = PyType_GenericNew,
	//.tp_init = PyColorScheme_init,
	.tp_repr = PyColorScheme_repr,
	//.tp_dealloc = PyGeneric_Dealloc,
	.tp_getset = PyColorSchemeGetDefs
};




/* Board CLASS */

typedef struct {
	PyObject_HEAD
	full_board_t *board;
	undoable_move_t *move_stack;
	size_t stack_size;
	size_t stack_capacity;
} PyBoardObject;


/*
static PyObject* PyBoard_alloc_in(PyTypeObject *cls, Py_ssize_t size) {
	PyBoardObject *self = PyObject_New(PyBoardObject, cls);
	
	if (!self) return NULL;
  self->board = PyMem_RawMalloc(sizeof(full_board_t));
	if (!self->board){
	 	Py_DECREF(self);
		return NULL;
	}
	self->board->position = PyMem_RawMalloc(sizeof(position_t));
	if (!self->board->position){
		PyMem_RawFree(self->board);
		self->board = NULL;
	 	Py_DECREF(self);
		return NULL;
	}
	self->stack_capacity = 10;
	self->move_stack = 
		PyMem_RawMalloc(self->stack_capacity * sizeof(undoable_move_t));	
	if (!self->move_stack){
		PyMem_RawFree(self->board->position);
		PyMem_RawFree(self->board);
		self->board->position = NULL;
		self->board = NULL;
		
		Py_DECREF(self);
		return NULL;
	}
	self->stack_size = 0;
	return (PyObject *)self;
}
*/


#define INIT_STACK_CAPACITY 10
static PyObject *PyBoard_new(PyTypeObject *subtype, PyObject *args, PyObject *kwds){
	//PyBoardObject *self = PyObject_New(PyBoardObject, subtype);
	PyBoardObject *self = (PyBoardObject*)subtype->tp_alloc(subtype, 0);
	if (!self) return NULL;
  self->board = PyMem_RawMalloc(sizeof(full_board_t));
	if (!self->board){
	 	Py_DECREF(self);
		return NULL;
	}
	self->board->position = PyMem_RawMalloc(sizeof(position_t));
	if (!self->board->position){
		PyMem_RawFree(self->board);
	 	Py_DECREF(self);
		return NULL;
	}
	self->stack_capacity = INIT_STACK_CAPACITY;
	self->move_stack = 
		PyMem_RawMalloc(self->stack_capacity * sizeof(undoable_move_t));	
	if (!self->move_stack){
		PyMem_RawFree(self->board->position);
		PyMem_RawFree(self->board);
		Py_DECREF(self);
		return NULL;
	}
	self->stack_size = 0;
	return (PyObject *)self;
}


static PyBoardObject* PyBoard_alloc(){
	return (PyBoardObject *)PyBoard_new(&PyBoardType, NULL, NULL);
	//return (PyBoardObject*)PyBoard_alloc_in(&PyBoardType, 0);
}

static void PyBoard_dealloc(PyObject *obj) {
		PyBoardObject *self = (PyBoardObject *)obj;
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

static PyObject *PyBoard_Wrap(full_board_t *board) {
	PyBoardObject *obj = PyBoard_alloc();
	if (obj) {
		memcpy(obj->board, board, sizeof(full_board_t));
		memcpy(obj->board->position, board->position, sizeof(position_t));
	}
	return (PyObject *)obj;
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
	if (!fen) {
		PyTypeErr("str", args);
		return NULL;
	}
	return PyBoard_from_fen_str(fen);
}

static void PyBoard_setup_starting(PyObject *self) {
	//const char *fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
	//parse_fen(fen, PyBoard_board(self)); 
	starting_board(PyBoard_board(self));
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
Board_init(PyObject *self, PyObject *args, PyObject *kwds){
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
PyBoard_repr(PyObject *self){
	char fen_buffer[128];
	make_fen(PyBoard_board(self), fen_buffer);
	return PyUnicode_FromFormat("<Board: \"%s\">", fen_buffer);
}


static PyObject *PyBoard_html(PyObject *self, PyObject *Py_UNUSED(args)){
	char html_buffer[20000];
	board_html(PyBoard_board(self), html_buffer);
	return PyUnicode_FromString(html_buffer);	
}

static PyObject *
PyBoard_legal_moves(PyObject *self, PyObject *Py_UNUSED(args)){
	move_t move_buffer[300];
	u_int8_t count = generate_legal_moves(PyBoard_board(self), move_buffer);		
	PyObject *list = PyList_New(count);
	for (int i = 0; i < count; i++) {
		PyObject *move_obj = PyMove_make(move_buffer[i]);
		PyList_SET_ITEM(list, i, (PyObject*)move_obj);
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

static PyObject *PyBoard_copy(PyObject *self, 
		PyObject *Py_UNUSED(args)){
	PyBoardObject *copy_obj = PyBoard_alloc();
	if (!copy_obj) return NULL;
	full_board_t *copy = copy_obj->board; 
	full_board_t *src = PyBoard_board(self);
	copy_into(copy, src);
	size_t stack_size = ((PyBoardObject *)self)->stack_size;
	size_t stack_capacity= ((PyBoardObject *)self)->stack_capacity;
	undoable_move_t * src_stack = ((PyBoardObject *)self)->move_stack;
	if (!PyBoard_set_capacity(copy_obj, stack_capacity)) {
		PyErr_SetString(PyExc_MemoryError, 
				"Could not copy Board, out of memory");
		Py_DECREF(copy_obj);
		return NULL;
	}
	memcpy(copy_obj->move_stack, 
			src_stack, 
			sizeof(undoable_move_t) * stack_size);
	copy_obj->stack_size = stack_size;
	return (PyObject *)copy_obj;
}


static inline bool PyBoard_apply_struct(PyBoardObject *board_obj, move_t move){
	int status;
	undoable_move_t undo = apply_move_checked(board_obj->board, 
			move, &status);
	switch (status){
		case EMPTY_ORIGIN: {
			PyErr_SetString(PyExc_ValueError, 
					"Could not apply move, origin is empty");
			}
			return false;
	}
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
	PyBoardObject *board_obj = (PyBoardObject *)self;
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
			Py_RETURN_NOTIMPLEMENTED;
	}
}


static PyObject *PyBoard_get_piece_at(PyObject *self, PyObject *key) {
	if (!PyTypeCheck("Square", key, &PySquareType)) return NULL;
	square_t square = PySquare_get(key);	
	full_board_t *board = PyBoard_board(self);
	piece_index_t piece = get_index_at(board->position, square);
	return PyPiece_index_make(piece);	
}

static inline PyObject *PyBoard_get_color_bb(PyObject *board, 
		PyObject *color){
	if (color == WhiteObject){
		return PyBitboard_make(PyBoard_board(board)->position->white_oc);
	}
	else {
		return PyBitboard_make(PyBoard_board(board)->position->black_oc);
	}
}


static inline PyObject *PyBoard_get_pt_bb(PyObject *board, 
		PyObject *piece_type){
	return PyBitboard_make(get_piece_type_bb(PyBoard_board(board)->position, 
			PyPieceType_get(piece_type)));	
}

static inline PyObject *PyBoard_get_bb(PyObject *board, 
		PyObject *color, PyObject *piece_type){
	piece_t piece = (piece_t){
		.color = PyColor_get(color),
		.type = PyPieceType_get(piece_type)
	};
	return PyBitboard_make(get_piece_bb(PyBoard_board(board)->position,
				piece));	
}

static PyObject *PyBoard_empty_bb(PyObject *self, void *closure) {
	position_t *pos= PyBoard_board(self)->position;
	return (PyObject *)PyBitboard_make(
		~(pos->white_oc | pos->black_oc)	
	);
}

static inline PyObject *PyBoard_get_index_tuple(PyObject *self,
		PyObject *key){
	PyObject *color;
	PyObject *piece_type;
	if (!PyArg_ParseTuple(key, "OO", &color, &piece_type)) 
		return NULL;
	if (!PyTypeCheck("Color as the first item", color, &PyColorType))
		return NULL;
	if (!PyTypeCheck("PieceType as the second item", piece_type, &PyPieceTypeType))
		return NULL;
	return PyBoard_get_bb(self, color, piece_type);	
}

static PyObject *PyBoard_get_index(PyObject *self, PyObject *key) {
	if (Py_IsNone(key)) {
		return PyBoard_empty_bb(self, NULL);
	}
	else if (Py_IS_TYPE(key, &PySquareType)){
		square_t square = PySquare_get(key);	
		full_board_t *board = PyBoard_board(self);
		piece_index_t piece = get_index_at(board->position, square);
		return PyPiece_index_make(piece);	
	}
	else if (Py_IS_TYPE(key, &PyPieceTypeType)) {
		return PyBoard_get_pt_bb(self, key);
	}
	else if (Py_IS_TYPE(key, &PyColorType)){
		return PyBoard_get_color_bb(self, key);
	}
	else if (PyTuple_Check(key)){
		return PyBoard_get_index_tuple(self, key);
	}
	else if (Py_IS_TYPE(key, &PyPieceType)){
		piece_t piece = PyPiece_get(key);
		return PyBitboard_make(get_piece_bb(PyBoard_board(self)->position,
				piece));	
	}
	PyTypeErr("PieceType, Color, Piece, Square,"
		 " tuple[Color, PieceType], or None", key);
	return NULL;
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

static PyObject *PyBoard_pretty(PyObject *self, PyObject *args, PyObject *kwargs){
	PyObject *color_scheme = OAK, 
					 *selected_obj = NULL, 
					 *highlight_obj = NULL;
	static char *kwlist[] = {
		"color_scheme", 
		"highlighted_squares", 
		"targeted_squares",
		NULL};
		if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOO", kwlist, 
					&color_scheme, &selected_obj, &highlight_obj)) {
			return NULL;
		}
	if (!PyTypeCheck("ColorScheme", color_scheme, &PyColorSchemeType)) return NULL;
	if (selected_obj && !PyTypeCheck("Bitboard", selected_obj, &PyBitboardType)) return NULL;
	if (highlight_obj && !PyTypeCheck("Bitboard", highlight_obj, &PyBitboardType)) return NULL;
	bitboard_t select_bb = selected_obj ? PyBitboard_get(selected_obj) : 0;	
	bitboard_t highlight_bb = highlight_obj ? PyBitboard_get(highlight_obj) : 0;	
	char buffer[2000];
	PyColorSchemeObject *cs = (PyColorSchemeObject *)color_scheme;
	unicode_write_board(PyBoard_board(self), 
			buffer, 
			cs->text_color,
			cs->light_color,
			cs->dark_color,
			cs->select_color,
			select_bb,
			highlight_bb
	);	
	return PyUnicode_FromString(buffer);
}


static Py_hash_t PyBoard_hash(PyObject *self){
	Py_hash_t h = hash_board(PyBoard_board(self), zobrist_table);
	if (h == -1) return -2;
	return h;
}


#define PYBOARD_PREDICATE(NAME)\
static PyObject *PyBoard_##NAME(PyObject *self, PyObject *Py_UNUSED(arg)){\
	PY_RETURN_BOOL(NAME(PyBoard_board(self)));\
}\



#define PYBOARD_STACK_PREDICATE(NAME)\
static PyObject *PyBoard_##NAME(PyObject *self, PyObject *Py_UNUSED(arg)){\
	PyBoardObject *board = (PyBoardObject *)self;\
	PY_RETURN_BOOL(NAME(board->board, board->move_stack, board->stack_size));\
}

/*
PYBOARD_STACK_PREDICATE(is_fivefold_repetition)
PYBOARD_STACK_PREDICATE(is_threefold_repetition)
PYBOARD_STACK_PREDICATE(board_is_draw)
PYBOARD_STACK_PREDICATE(board_is_forced_draw)	
PYBOARD_PREDICATE(is_checkmate)
PYBOARD_PREDICATE(is_stalemate)
PYBOARD_PREDICATE(in_check)
PYBOARD_PREDICATE(is_insufficient_material)
PYBOARD_PREDICATE(can_claim_fifty)
PYBOARD_PREDICATE(is_seventy_five)
*/

static PyMethodDef board_methods[] = { 
    {"from_fen", PyBoard_from_fen, METH_O | METH_STATIC, NULL},  
    {"empty", PyBoard_empty, METH_NOARGS | METH_STATIC, NULL},  
		{"_repr_html_", PyBoard_html, METH_NOARGS, NULL},
		{"fen", PyBoard_to_fen, METH_NOARGS, NULL},
		{"pretty", (PyCFunction) PyBoard_pretty, METH_VARARGS | METH_KEYWORDS, NULL},
		/*
		{"is_insufficient_material", PyBoard_is_insufficient_material, METH_NOARGS, NULL},
		{"is_draw", PyBoard_board_is_draw, METH_NOARGS, NULL},
		{"is_fifty_move_timeout", PyBoard_can_claim_fifty, METH_NOARGS, NULL},
		{"is_seventy_five_move_timeout", PyBoard_is_seventy_five, METH_NOARGS, NULL},
		{"is_fivefold_repetition", PyBoard_is_fivefold_repetition, METH_NOARGS, NULL},
		{"is_threefold_repetition", PyBoard_is_threefold_repetition, METH_NOARGS, NULL},
		{"is_forced_draw", PyBoard_board_is_forced_draw, METH_NOARGS, NULL},
		{"is_checkmate", PyBoard_is_checkmate, METH_NOARGS, NULL},
		{"is_stalemate", PyBoard_is_stalemate, METH_NOARGS, NULL},
		{"is_check", PyBoard_in_check, METH_NOARGS, NULL},
		*/
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

static inline char *new_ep_legal(full_board_t *board, square_t ep) {
	bitboard_t ep_bb = SQUARE_TO_BB(ep);
	bitboard_t on_3 = ep_bb & RANK_3;
	bitboard_t on_6 = ep_bb & RANK_6;
	if (!on_3 && !on_6) {
		return "Must be on either rank 3 or rank 6";
	}	
	position_t *pos = board->position;
	bitboard_t white_pawns = pos->pawns & pos->white_oc;
	bitboard_t black_pawns = pos->pawns & pos->black_oc;
	if (board->turn == WHITE_VAL) {
		if (on_3) return "Must be on rank 6 if it is white's turn";
		if (!(SAFE_BELOW_BB(ep_bb) & black_pawns)) 
			return "There is no corresponding black pawn";
	}
	else {	
			if (on_6) return "Must be on rank 3 if it is black's turn";
			if (!(SAFE_ABOVE_BB(ep_bb) & white_pawns))
				return "There is no corresponding white pawn";
			
	}
	return 0;
}

static int PyBoard_ep_set(PyObject *self, PyObject *val){
	if (Py_IsNone(val)) {
		PyBoard_board(self)->en_passant_square.exists = false;
		return 0;
	}
	if (!PyTypeCheck("Square or None", val, &PySquareType)) return -1;
	square_t ep_sq = PySquare_get(val);
	char *err = new_ep_legal(PyBoard_board(self), ep_sq);
	if (err) {
		PyErr_Format(PyExc_ValueError,
				"Illegal en passant Square: %S. %s.", val, err);
		return -1;
	}
	PyBoard_board(self)->en_passant_square.exists = true;
  PyBoard_board(self)->en_passant_square.square	= ep_sq;	
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




static PyObject *PyBoard_halfmove_get(PyObject *self, void *closure) {
	return PyLong_FromUnsignedLong(PyBoard_board(self)->halfmove_clock);
}


#define BOARD_CLOCK_SETTER(FIELD)\
static int PyBoard_##FIELD##_set(PyObject *self, PyObject *val){\
	if (!PyTypeCheck("int", val, &PyLong_Type)) return -1;\
	long long raw = PyLong_AsUnsignedLongLong(val);\
	if (raw == -1 || UINT64_MAX < raw) {\
		PyErr_Format(PyExc_OverflowError, "a value < %lld", UINT64_MAX);\
		return -1;\
	}	\
	PyBoard_board(self)->FIELD = raw;\
	return 0;\
}\

BOARD_CLOCK_SETTER(halfmove_clock)

BOARD_CLOCK_SETTER(fullmove_number)

static int PyBoard_contains(PyObject *self, PyObject *arg){
	position_t *pos = PyBoard_board(self)->position;
	if (Py_IsNone(arg)) {
		return ~(pos->white_oc | pos->black_oc) ? 1 : 0;
	}
	if (!PyTypeCheck("Piece or None", arg, &PyPieceType)) return -1;
	piece_t piece = PyPiece_get(arg);
	bitboard_t piece_bb;
	switch (piece.type) {
		case PAWN_VAL:
		piece_bb = pos->pawns; 
		break;
		case KNIGHT_VAL:
		piece_bb = pos->knights;
		break;
		case BISHOP_VAL:
		piece_bb = pos->bishops;
		break;
		case ROOK_VAL:
		piece_bb = pos->rooks;
		break;
		case QUEEN_VAL:
		piece_bb = pos->queens;
		break;
		default:
		piece_bb = pos->kings;
	}
	bitboard_t color_bb;
	if (piece.color == WHITE_VAL) color_bb = pos->white_oc;
	else color_bb = pos->black_oc;
	return piece_bb & color_bb ? 1 : 0;
}


static PyObject *PyBoard_castling_rights(PyObject *self, void * closure){ 
	return (PyObject *)PyCastlingRights_make(PyBoard_board(self)->castling_rights);
}


static int PyBoard_set_castling_rights(PyObject *self, PyObject *arg,
		void * closure){ 
	if (!PyTypeCheck("CastlingRights", arg, &PyCastlingRightsType)){
		return -1;
	}
	castling_rights_t new_cr = PyCastlingRights_get(arg);
	full_board_t *board = PyBoard_board(self);
	if (valid_castling(board, new_cr)) {
		board->castling_rights = new_cr;
		return 0;
	}
	else {
		//char fen[100];
		//make_fen(board, fen);
		PyErr_Format(PyExc_ValueError, "%R is illegal for %R", arg, self);
		return -1;
	}
}

static PyObject *PyBoard_history(PyObject *self, void *closure){
	PyBoardObject *board = (PyBoardObject *)self;
	PyObject *list = PyList_New(board->stack_size);
	for (int i = 0; i < board->stack_size; i++){
		PyObject *move = PyMove_make(board->move_stack[i].move);
		if (!move){
			for (int j = 0; j < i; j++){
				Py_DECREF(PyList_GET_ITEM(list, j));
			}
			return NULL;
		}
		PyList_SET_ITEM(list, i, move);
	}	
	return list;
}


static PyGetSetDef Board_getset[] = {
    {"turn", 
			(getter)PyBoard_turn_get, (setter)PyBoard_turn_set, NULL, NULL},
    {"fullmove_number", 
			(getter)PyBoard_fullmove_get, (setter)PyBoard_fullmove_number_set, NULL, NULL},
    {"halfmove_clock", 
			(getter)PyBoard_halfmove_get, (setter)PyBoard_halfmove_clock_set, NULL, NULL},
    {"en_passant_square", 
			(getter)PyBoard_ep_square, (setter)PyBoard_ep_set, NULL, NULL},
 		{"history", PyBoard_history, NULL, NULL, NULL},	
		{"castling_rights",
			PyBoard_castling_rights, PyBoard_set_castling_rights, NULL, NULL},	
		{NULL}
};

static PyMappingMethods PyBoardAsMap = {
	.mp_subscript = PyBoard_get_index,
	.mp_ass_subscript = PyBoard_set_piece_at,
	.mp_length = NULL,
};

static PySequenceMethods PyBoardAsSeq = {
	.sq_contains = PyBoard_contains
};


static PyObject *PyBoard_str(PyObject *self){
	char buffer[200];
	str_write_board(PyBoard_board(self), buffer);
	return PyUnicode_FromString(buffer);
}

static PyTypeObject PyBoardType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Board",
	.tp_basicsize = sizeof(PyBoardObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_dealloc = PyBoard_dealloc,
	.tp_new = PyBoard_new,
	.tp_methods = board_methods,
	.tp_init = Board_init,
	.tp_getset = Board_getset,
	.tp_richcompare = PyBoard_compare,
	.tp_as_mapping = &PyBoardAsMap,
	.tp_repr = PyBoard_repr,
	.tp_str = PyBoard_str,
	.tp_hash = PyBoard_hash,
	.tp_as_sequence = &PyBoardAsSeq
};


/* BoardStatus CLASS */


typedef struct {
	PyObject_HEAD
	board_status_t status_type; 
} PyBoardStatusObject;


static PyTypeObject PyBoardStatusType;

static PyBoardStatusObject *PyBoardStatus_make(board_status_t status_type){
	PyBoardStatusObject *self = PyObject_New(PyBoardStatusObject, &PyBoardStatusType);
	if (!self) return NULL;
	Py_INCREF(self);
	self->status_type = status_type;
	return self;

}

#define MAKE_STATUS(VAR, VAL)\
	VAR = (PyObject *)PyBoardStatus_make(VAL);\
	if (!VAR) goto err

PyObject *CHECK_OBJ = NULL;
PyObject *MATE_OBJ = NULL;
PyObject *INSUFFICIENT_OBJ = NULL;
PyObject *FIFTY_OBJ = NULL;
PyObject *SEVENTY_FIVE_OBJ = NULL;
PyObject *THREE_FOLD_OBJ = NULL;
PyObject *FIVE_FOLD_OBJ = NULL;
PyObject *DRAW_OBJ= NULL;
PyObject *FORCED_DRAW_OBJ = NULL;
PyObject *STALEMATE_OBJ = NULL;
PyObject *CHECKMATE_OBJ = NULL;


static bool PyBoardStatus_make_all(){
	MAKE_STATUS(CHECK_OBJ, CHECK_STATUS);
	MAKE_STATUS(MATE_OBJ, MATE_STATUS);
	MAKE_STATUS(INSUFFICIENT_OBJ, INSUFFICIENT_MATERIAL);
	MAKE_STATUS(FIFTY_OBJ, FIFTY_MOVE_TIMEOUT);
	MAKE_STATUS(SEVENTY_FIVE_OBJ, SEVENTY_FIVE_MOVE_TIMEOUT);
	MAKE_STATUS(THREE_FOLD_OBJ, THREE_FOLD_REPETITION);
	MAKE_STATUS(FIVE_FOLD_OBJ, FIVE_FOLD_REPETITION);
	MAKE_STATUS(DRAW_OBJ, DRAW_STATUS);
	MAKE_STATUS(FORCED_DRAW_OBJ, FORCED_DRAW_STATUS);
	MAKE_STATUS(CHECKMATE_OBJ, CHECKMATE_STATUS);
	MAKE_STATUS(STALEMATE_OBJ, STALEMATE_STATUS);
	return true;
	err:
	Py_XDECREF(CHECK_OBJ);
	Py_XDECREF(MATE_OBJ);
	Py_XDECREF(INSUFFICIENT_OBJ);
	Py_XDECREF(FIFTY_OBJ);
	Py_XDECREF(SEVENTY_FIVE_OBJ);
	Py_XDECREF(THREE_FOLD_OBJ);
	Py_XDECREF(FIVE_FOLD_OBJ);
	Py_XDECREF(DRAW_OBJ);
	Py_XDECREF(FORCED_DRAW_OBJ);
	Py_XDECREF(STALEMATE_OBJ);
	Py_XDECREF(CHECKMATE_OBJ);
	return false;
}


static inline board_status_t PyBoardStatus_get(PyObject *self){
	return ((PyBoardStatusObject *)self)->status_type;
}

static PyObject *PyBoardStatus_repr(PyObject *self){
	char *str;
	switch (PyBoardStatus_get(self)) {
		case CHECK_STATUS:
			str = "CHECK"; break;
		case MATE_STATUS:
			str = "MATE"; break;
		case INSUFFICIENT_MATERIAL:
			str = "INSUFFICIENT_MATERIAL"; break;
		case FIFTY_MOVE_TIMEOUT:
			str = "FIFTY_MOVE_TIMEOUT"; break;
		case SEVENTY_FIVE_MOVE_TIMEOUT:
			str = "SEVENTY_FIVE_MOVE_TIMEOUT"; break;
		case THREE_FOLD_REPETITION:
			str = "THREE_FOLD_REPETITION"; break;
		case FIVE_FOLD_REPETITION:
			str = "FIVE_FOLD_REPETITION"; break;
		case DRAW_STATUS:
			str = "DRAW"; break;
		case FORCED_DRAW_STATUS:
			str = "FORCED_DRAW"; break;
		case CHECKMATE_STATUS:
			str = "CHECKMATE"; break;
		case STALEMATE_STATUS:
			str = "STALEMATE"; break;
		default:
			str = "???";
	}
	return PyUnicode_FromFormat("<BoardStatus: %s>", str);
}

static int PyBoardStatus_contains(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return -1;
	PyBoardObject *board_obj = (PyBoardObject *)arg;
	full_board_t *board = PyBoard_board(arg);
	switch (PyBoardStatus_get(self)){
		case CHECK_STATUS:
			return in_check(board) ? 1 : 0;
		case MATE_STATUS:
			return has_legal_moves(board) ? 0 : 1;
		case INSUFFICIENT_MATERIAL:
			return is_insufficient_material(board) ? 1 : 0; 
		case FIFTY_MOVE_TIMEOUT:
			return can_claim_fifty(board) ? 1 : 0;
		case SEVENTY_FIVE_MOVE_TIMEOUT:
			return is_seventy_five(board) ? 1 : 0;
		case THREE_FOLD_REPETITION:
			return is_threefold_repetition(
					board, board_obj->move_stack, board_obj->stack_size) ? 1 : 0;	
		case FIVE_FOLD_REPETITION:
			return is_fivefold_repetition(
					board, board_obj->move_stack, board_obj->stack_size) ? 1 : 0;
		case CHECKMATE_STATUS:
			return is_checkmate(board) ? 1 : 0;
		case STALEMATE_STATUS:
			return is_stalemate(board) ? 1 : 0;
		case DRAW_STATUS:
			return board_is_draw(board, board_obj->move_stack, board_obj->stack_size)
				? 1 : 0;
		case FORCED_DRAW_STATUS:	
			return board_is_forced_draw(board, 
					board_obj->move_stack, board_obj->stack_size)
				? 1 : 0;
	
		default:
			PyErr_SetString(PyExc_ValueError, "Unknown Board Status");
			return -1;		
	}	
}

Py_hash_t PyBoardStatus_hash(PyObject *self) {
	return (Py_hash_t)PyBoardStatus_get(self);
}

static PySequenceMethods PyBoardStatusAsSeq = {
	.sq_contains = PyBoardStatus_contains
};




static PyTypeObject PyBoardStatusType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.BoardStatus",
	.tp_basicsize = sizeof(PyBoardStatusType),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_repr = PyBoardStatus_repr,
	.tp_as_sequence = &PyBoardStatusAsSeq,
	.tp_hash = PyBoardStatus_hash,
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
	unsigned char depth;	
	if (!PyArg_ParseTuple(args, "Ob", &board, &depth)) return NULL; 
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL;
	PyObject *out = PyLong_FromUnsignedLongLong(perft(PyBoard_board(board), depth)); 
	return out;
}

static PyObject *PyUtils_perft_fen(PyObject *self, PyObject *args){
	char *fen;
	unsigned char depth;	
	if (!PyArg_ParseTuple(args, "sb", &fen, &depth)) return NULL; 
	full_board_t board;
	position_t pos;
	board.position = &pos;
	parse_fen(fen, &board);
	PyObject *out = PyLong_FromUnsignedLongLong(perft(&board, depth)); 
	return out;
}


/*
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
*/

#define UTIL_FROM_BOARD_TO_BB(func) static PyObject *PyUtils_ ## func \
	(PyObject *self, PyObject *args){ \
		if (!PyTypeCheck("Board", args, &PyBoardType)) return NULL; \
		return (PyObject *)PyBitboard_make(func(PyBoard_board(args))); \
	}

#define UTIL_FROM_BOARD_OPT_COLOR_TO_BB(func)\
static PyObject *PyUtils_ ## func (PyObject *self,\
		PyObject *args, PyObject *kwargs) { \
		PyObject *board_obj;\
		PyObject *color_obj = NULL;\
		static char* kwlist[] = {"board", "color", 0};\
		if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O|O", kwlist,\
					&board_obj, &color_obj))\
			return NULL;\
		if (!PyTypeCheck("Board", board_obj, &PyBoardType)) return NULL; \
		full_board_t *board = PyBoard_board(board_obj);\
		if (!color_obj || Py_IsNone(color_obj)) return \
			(PyObject *)PyBitboard_make(func(board));\
		if (!PyTypeCheck("Color or None", color_obj, &PyColorType))\
		return NULL;\
		switch (PyColor_get(color_obj)){\
			case WHITE_VAL:\
				return (PyObject *)PyBitboard_make(white_## func(board));\
			default:\
				return (PyObject *)PyBitboard_make(black_## func(board));\
		}\
}


UTIL_FROM_BOARD_OPT_COLOR_TO_BB(isolated_pawns)
UTIL_FROM_BOARD_OPT_COLOR_TO_BB(backwards_pawns)
UTIL_FROM_BOARD_OPT_COLOR_TO_BB(doubled_pawns)
UTIL_FROM_BOARD_OPT_COLOR_TO_BB(passed_pawns)

UTIL_FROM_BOARD_TO_BB(open_files)


static PyObject *PyUtils_attack_mask(PyObject*self, PyObject*args) { 
	PyObject *board;
	PyObject *color;
	if (!PyArg_ParseTuple(args, "OO", &board, &color)) return NULL;
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL; 
	if (!PyTypeCheck("Color", color, &PyColorType)) return NULL; 
	bitboard_t attack_mask = make_attack_mask(PyBoard_board(board), PyColor_get(color));
	return (PyObject *)PyBitboard_make(attack_mask);
}


static PyObject *PyUtils_half_open_files(PyObject *self, PyObject *args){
	PyObject *board;
	PyObject *color;
	if (!PyArg_ParseTuple(args, "OO", &board, &color)) return NULL;
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL; 
	if (!PyTypeCheck("Color", color, &PyColorType)) return NULL; 
	bitboard_t mask= half_open_files(PyBoard_board(board), 
			PyColor_get(color));
	return (PyObject *)PyBitboard_make(mask);
}




// too dependent on implementation details, not intuitive on its own
/*
static PyObject *PyUtils_pinned_mask(PyObject*self, PyObject*args) { 
	PyObject *board;
	PyObject *square;
	if (!PyArg_ParseTuple(args, "OO", &board, &square)) return NULL;
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL; 
	if (!PyTypeCheck("Square", square, &PySquareType)) return NULL; 
	bitboard_t pinned_mask = ext_get_pinned_mask(PyBoard_board(board), 
			PySquare_get(square));
	return (PyObject *)PyBitboard_make(pinned_mask);
}
*/





static PyObject *PyReset_Hash(PyObject *self, PyObject *Py_UNUSED(args)){
	fill_zobrist_table(zobrist_table);
	Py_RETURN_NONE;
}

static PyObject *PyUtils_evaluate(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	PyBoardObject *board = (PyBoardObject *)arg;
	int32_t eval = shannon_evaluation(board->board, board->move_stack, board->stack_size);
	return PyLong_FromLong(eval);
}


static PyObject *PyUtils_material(PyObject *self, PyObject *args, PyObject *kwargs){
	PyObject *board_obj;
	int64_t pawn_val = 100, 
					knight_val = 300, 
					bishop_val = 300, 
					rook_val = 500, 
					queen_val = 900;
	static char *kwlist[] = 
	{"board", "pawn_value", "knight_value", "bishop_value", "rook_value", "queen_value", NULL};
	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O|LLLLL", kwlist, 
				&board_obj, &pawn_val, &knight_val, &bishop_val, &rook_val, &queen_val)) 
		return NULL;
	if (!PyTypeCheck("Board", board_obj, &PyBoardType)) return NULL;
	PyBoardObject *board = (PyBoardObject *)board_obj;
	int64_t mat = material(board->board, pawn_val, knight_val, 
			bishop_val, rook_val, queen_val); 
	return PyLong_FromLongLong(mat);
}


static PyObject *PyUtils_mobility(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	PyBoardObject *board = (PyBoardObject *)arg;
	int mob = net_mobility(board->board); 
	return PyLong_FromLong(mob);
}

static PyObject *PyUtils_random_legal_move(PyObject *self, PyObject *arg){
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	PyBoardObject *board = (PyBoardObject*)arg;
	return PyMove_from_opt(random_legal_move(board->board));
}


static PyObject *PyUtils_is_pinned(PyObject *self, PyObject *args){
	PyObject *arg1, *arg2;
	if (!PyArg_ParseTuple(args, "OO", &arg1, &arg2)) return NULL;
	if (!PyTypeCheck("Board", arg1, &PyBoardType)) return NULL;
	if (!PyTypeCheck("Square", arg2, &PySquareType)) return NULL;
	PY_RETURN_BOOL(is_pinned(PyBoard_board(arg1), PySquare_get(arg2)));
}

static PyObject *PyUtils_boards_legally_equal(PyObject *self,
		PyObject *args){
	PyObject *board1, *board2;
	if (!PyArg_ParseTuple(args, "OO", &board1, &board2)) return NULL;
	if (!PyTypeCheck("Board", board1, &PyBoardType)) return NULL;
	if (!PyTypeCheck("Board", board2, &PyBoardType)) return NULL;
	PY_RETURN_BOOL(boards_legally_equal(
		PyBoard_board(board1),
		PyBoard_board(board2)
	));
}

static PyObject *PyUtils_boards_deeply_equal(PyObject *self,
		PyObject *args){
	PyObject *arg1, *arg2;
	if (!PyArg_ParseTuple(args, "OO", &arg1, &arg2)) return NULL;
	if (!PyTypeCheck("Board", arg1, &PyBoardType)) return NULL;
	if (!PyTypeCheck("Board", arg2, &PyBoardType)) return NULL;
	PyBoardObject *board1 = (PyBoardObject *)arg1;
	PyBoardObject *board2 = (PyBoardObject *)arg2;
	if (boards_equal(board1->board, board2->board)){
		if (board1->stack_size == board2->stack_size){
			for (int i = board1->stack_size - 1; i >= 0; i--) {
				if (!moves_equal(
							board1->move_stack[i].move,
							board2->move_stack[i].move
						)) Py_RETURN_FALSE;
			}
			Py_RETURN_TRUE;
		}	
	}
	Py_RETURN_FALSE;	
}

#define POSITION_GETTER(NAME)\
static PyObject *PyUtils_##NAME(PyObject *self, PyObject *arg){\
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;\
	full_board_t *board = PyBoard_board(arg);\
	return (PyObject *)PyBitboard_make(board->position->NAME);\
}\

POSITION_GETTER(pawns)
POSITION_GETTER(knights)
POSITION_GETTER(rooks)
POSITION_GETTER(bishops)
POSITION_GETTER(queens)
POSITION_GETTER(kings)
POSITION_GETTER(white_oc)
POSITION_GETTER(black_oc)

static PyObject *PyUtils_empty(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("Board", arg, &PyBoardType)) return NULL;
	return PyBoard_empty_bb(arg, NULL);	
}


static PyObject *PyUtils_random_board(PyObject *self, 
		PyObject *Py_UNUSED(args)){
	PyBoardObject *board = PyBoard_alloc();
	if (!board) return NULL;
	//setstate(rand_state);
	PyBoard_setup_starting((PyObject *)board);
	u_int8_t depth = 4 + (random() % 300);
	move_t moves[256];
	PyBoard_set_capacity(board, depth * 1 + 5);	
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

static PyObject *PyUtils_piece_bitboard(PyObject *self, 
		PyObject *args){
	PyObject *board;
	PyObject *piece;
	if (!PyArg_ParseTuple(args, "OO", &board, &piece)) return NULL;
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL;
	if (!PyTypeCheck("Piece", piece, &PyPieceType)) return NULL;
	piece_t p= PyPiece_get(piece);	
	return PyBitboard_make(
			get_piece_bb(PyBoard_board(board)->position,
			p));
}

#define POSITION_OBJ(FIELD, NAME)\
{NAME, PyUtils_##FIELD, METH_O, NULL}

static PyObject *PyUtils_king_sq(PyObject *self, PyObject *args){
	PyObject *board;
	PyObject *color;
	if (!PyArg_ParseTuple(args, "OO", &board, &color)) return NULL;
	if (!PyTypeCheck("Board", board, &PyBoardType)) return NULL;
	if (!PyTypeCheck("Color", color, &PyColorType)) return NULL;
	full_board_t *b = PyBoard_board(board);
	position_t *pos = b->position;
	bitboard_t king_bb = pos->kings;
	if (PyColor_get(color) == WHITE_VAL){
		king_bb &= pos->white_oc;	
	}
	else {
		king_bb &= pos->black_oc;
	}
	square_t sq = unchecked_bb_to_square(king_bb);	
	if (sq == ERR_SQ) {
		PyErr_Format(PyExc_AttributeError, 
				"Board has multiple %S kings", color);
		return NULL;
	}	
	else return PySquare_make(sq);
}

static PyMethodDef PyUtilsMethods[] = {
	POSITION_OBJ(pawns, "pawn_bitboard"),
	POSITION_OBJ(knights, "knight_bitboard"),
	POSITION_OBJ(bishops, "bishop_bitboard"),
	POSITION_OBJ(rooks, "rook_bitboard"),
	POSITION_OBJ(queens, "queen_bitboard"),
	POSITION_OBJ(kings, "king_bitboard"),
	POSITION_OBJ(white_oc, "white_bitboard"),
	POSITION_OBJ(black_oc, "black_bitboard"),
	{"king_square", PyUtils_king_sq, METH_VARARGS, NULL},
	{"unoccupied_bitboard", PyUtils_empty, METH_O, NULL},
	{"piece_bitboard", PyUtils_piece_bitboard, METH_VARARGS, NULL},
	{"legally_equal", PyUtils_boards_legally_equal, METH_VARARGS, NULL},
	{"deeply_equal", PyUtils_boards_deeply_equal, METH_VARARGS, NULL},
	{"evaluate", PyUtils_evaluate, METH_O, NULL},		
	{"mobility", PyUtils_mobility, METH_O, NULL},
	{"material", (PyCFunction)PyUtils_material, METH_KEYWORDS | METH_VARARGS, NULL},
	{"attack_mask", PyUtils_attack_mask, METH_VARARGS, NULL},	
	{"half_open_files", PyUtils_half_open_files, METH_VARARGS, NULL},	
	{"is_pinned", PyUtils_is_pinned, METH_VARARGS, NULL},
	{"random_legal_move", PyUtils_random_legal_move, METH_O, NULL},
	{"open_files", PyUtils_open_files, METH_O, NULL},	
	{"isolated_pawns", (PyCFunction)PyUtils_isolated_pawns, 
		METH_VARARGS | METH_KEYWORDS, NULL},	
	{"backwards_pawns", (PyCFunction)PyUtils_backwards_pawns, 
		METH_VARARGS | METH_KEYWORDS, NULL},	
	{"passed_pawns", (PyCFunction)PyUtils_passed_pawns, 
		METH_VARARGS | METH_KEYWORDS, NULL},	
	{"doubled_pawns", (PyCFunction)PyUtils_doubled_pawns, 
		METH_KEYWORDS | METH_VARARGS, NULL},	
	{"count_moves", PyUtils_count_moves, METH_O, NULL},	
	{"is_quiescent", PyUtils_is_quiescent, METH_O, NULL},	
	{"perft", PyUtils_perft,  METH_VARARGS, NULL},	
	{"perft_fen", PyUtils_perft_fen,  METH_VARARGS, NULL},	
	//{"set_random_seed", PyUtils_srandom, METH_O, NULL},
	{"random_board", PyUtils_random_board, METH_NOARGS, NULL},
	//{"reset_hashing", PyReset_Hash, METH_NOARGS, NULL},
	{NULL, NULL, 0, NULL}
};



/* PGN */

typedef struct {
	PyObject_HEAD
	date_t date;
} PyPGNDateObject;

static PyTypeObject PyPGNDateType;

#define PGNDATE_MAKE_GETTER(field) static PyObject *PyPGNDate_ ## field(PyObject *self, void *closure) {\
	date_t date = ((PyPGNDateObject *)self)->date;\
	if (date.known_##field) return PyLong_FromUnsignedLongLong(date.field);\
	else Py_RETURN_NONE;\
}\


PGNDATE_MAKE_GETTER(year)
PGNDATE_MAKE_GETTER(month)
PGNDATE_MAKE_GETTER(day)

static PyGetSetDef PyPGNDate_getset[] = {
    {"year", (getter)PyPGNDate_year, NULL, NULL, NULL},
    {"month", (getter)PyPGNDate_month, NULL, NULL, NULL},
    {"day", (getter)PyPGNDate_day, NULL, NULL, NULL},
		{NULL}
};

static PyObject *PyPGNDate_make(date_t date){
	PyPGNDateObject *obj = PyObject_NEW(PyPGNDateObject, &PyPGNDateType);
	obj->date = date;
	return (PyObject *)obj;
}

static int PyObject_ToPositiveIntInRange(PyObject *obj, const char *field_name, int min, int max) {
	if (!PyTypeCheck("int", obj, &PyLong_Type)) return -1;
	int i = PyLong_AsInt(obj);
	if (i < min || i > max) {
		PyErr_Format(PyExc_ValueError, "The given %s value %S is out of range, must be between or equal to %d and %d", field_name, obj, min, max);
		return -1;
	}
	return i;
}

#define INIT_DATE_FIELD(FIELD)\
	if (Py_IsNone(FIELD)) {\
		date.known_##FIELD = false;\
	}\
	else {\
		date.known_##FIELD = true;\
		int FIELD ## _int = PyObject_ToPositiveIntInRange(FIELD, #FIELD, 0, 9999);\
		if (FIELD ## _int != -1) {\
			date.FIELD = FIELD ##_int;\
		}\
		else return -1;\
	}\
	
#define MAKE_DATE_ARG(FIELD)\
	bool known_##FIELD = false;\
	int int_##FIELD = 0;\
	if (!FIELD || Py_IsNone(FIELD)){\
    known_##FIELD = false;\
	}\
	else {\
		int_##FIELD = PyLong_AsInt(FIELD);\
		known_##FIELD = true;\
		if (int_##FIELD == -1 && PyErr_Occurred())\
			return -1;\
	}\

static int PyPGNDate_init(PyObject *self, PyObject *args, PyObject *kwds){
	PyObject *year = NULL;
	PyObject *month = NULL;
	PyObject *day = NULL;
  static char *const kwlist[] = {"year", "month", "day", NULL};
	if (!PyArg_ParseTupleAndKeywords(args, kwds, "|OOO", kwlist, &year, &month, &day)) 
		return -1;
	MAKE_DATE_ARG(year)
	MAKE_DATE_ARG(month)
	MAKE_DATE_ARG(day)	
	date_t date;
	const char *err = make_date(
			&date,
		 	int_year, 
			int_month, 
			int_day, 
			known_year, 
			known_month, 
			known_day
	);	
	if (err){
		PyErr_Format(PyExc_ValueError, "%s", err); 
		return -1;
	}	
	((PyPGNDateObject *)self)->date = date;	
	return 0;
}


#define FILL_DATE(self)\
	char year[5];\
	date_t date = ((PyPGNDateObject *)self)->date;\
	if (!date.known_year) strcpy(year, "????");\
	else sprintf(year, "%04d", date.year);\
	char month[3];\
	if (!date.known_month) strcpy(month, "??");\
	else sprintf(month, "%02d", date.month);\
	char day[3];\
	if (!date.known_day) strcpy(day, "??");\
	else sprintf(day, "%02d", date.day);\
	
static PyObject *PyPGNDate_to_str(PyObject *self) {
	FILL_DATE(self);
	return PyUnicode_FromFormat("%s.%s.%s", year, month, day);	
}
	
static PyObject *PyPGNDate_repr(PyObject *self) {
	FILL_DATE(self);
	return PyUnicode_FromFormat("<PGNDate: %s.%s.%s>", year, month, day);	
}



#define DEBUG(v) (printf(#v " is %d\n"), v) 

#define FIELD_EQ(FIELD) ((date1.known_##FIELD) ? ((date2.known_##FIELD) && ((date1.FIELD == date2.FIELD))) : (!date2.known_##FIELD))
#define FIELD_OP(OP, FIELD) (date1.FIELD OP date2.FIELD)
#define DATE_EQ  (same_type && FIELD_EQ(year) && FIELD_EQ(month) && FIELD_EQ(day)) 

#define FIELD_KNOWN(FIELD)\
	(date1.known_ ##FIELD && date2.known_ ##FIELD)

#define FIELD_ALL_UNK(FIELD)\
	(!date1.known_ ##FIELD && !date2.known_ ##FIELD)



#define DATE_OP(OP){\
	if (same_type) {\
		if ((FIELD_KNOWN(year))){\
			if (FIELD_OP(OP, year)) Py_RETURN_TRUE;\
			else if (FIELD_OP(==, year)) {\
				if (FIELD_KNOWN(month)){\
					if (FIELD_OP(OP, month)) Py_RETURN_TRUE;\
					else if (FIELD_OP(==, month)){\
						if (FIELD_KNOWN(day) && (FIELD_OP(OP, day))) Py_RETURN_TRUE;\
						Py_RETURN_FALSE;\
				}\
				else Py_RETURN_FALSE;\
			}\
			else Py_RETURN_FALSE;\
		}\
	}\
	else Py_RETURN_FALSE;\
}else Py_RETURN_FALSE;}

static PyObject *PyPGNDate_compare(PyObject *self, PyObject *other, int op){
	bool same_type = Py_IS_TYPE(other, &PyPGNDateType); 	
	date_t date1;
	date_t date2;
	if (same_type) {
		date1 = ((PyPGNDateObject *)self)->date;
		date2 = ((PyPGNDateObject *)other)->date;
	}	
	switch (op) {
		case Py_EQ:
			return DATE_EQ ? Py_True : Py_False;
		case Py_NE:
			return DATE_EQ ? Py_False : Py_True;
		case Py_LT:
			DATE_OP(<)
		case Py_GT:
			DATE_OP(>)
		case Py_GE:
			DATE_OP(>=)
		case Py_LE:
			DATE_OP(<=)
		default:
			Py_RETURN_NOTIMPLEMENTED;
	}
}




static PyTypeObject PyPGNDateType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.pgn.PGNDate",
	.tp_basicsize = sizeof(PyPGNDateObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PyPGNDate_to_str,	
	.tp_repr = PyPGNDate_repr,	
	.tp_getset = PyPGNDate_getset,
	.tp_new = PyType_GenericNew,
	.tp_init = PyPGNDate_init,
	.tp_richcompare = PyPGNDate_compare
};



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
	PyObject *out = (PyObject *)PyResults[res];
	Py_INCREF(out);
	return out;
}

#define RESULT_TO_GET(field, draw, white, black, unk, wrapper)\
static PyObject* PyPGNResult_ ## field (PyObject *self, void *closure) {\
	PyPGNResultObject *obj = (PyPGNResultObject *)self; \
	PyObject *out;\
	switch (obj->result) {\
		case DRAW_RES: out = (PyObject *)wrapper(draw);break;\
		case WHITE_RES: out = (PyObject *)wrapper(white);break;\
		case BLACK_RES: out = (PyObject *)wrapper(black);break;\
		default: out = (PyObject *)wrapper(unk);break;\
	}\
	return out;\
}\

#define RESULT_TO_FNC(field, draw, white, black, unk, wrapper)\
static PyObject* PyPGNResult_ ## field (PyObject *self) {\
	PyPGNResultObject *obj = (PyPGNResultObject *)self; \
	PyObject *out;\
	switch (obj->result) {\
		case DRAW_RES: out = (PyObject *)wrapper(draw);break;\
		case WHITE_RES: out = (PyObject *)wrapper(white);break;\
		case BLACK_RES: out = (PyObject *)wrapper(black);break;\
		default: out = (PyObject *)wrapper(unk);break;\
	}\
	return out;\
}\



RESULT_TO_GET(winner, Py_None, WhiteObject, BlackObject, Py_None,)
RESULT_TO_GET(is_unknown, Py_False, Py_False, Py_False, Py_True, )
RESULT_TO_GET(is_draw, Py_True, Py_False, Py_False, Py_False, )
RESULT_TO_FNC(to_str, "1/2-1/2", "1-0", "0-1", "*", PyUnicode_FromString)
RESULT_TO_FNC(repr, 
		"<PGNResult: \"1/2-1/2\">", 
		"<PGNResult: \"1-0\">", 
		"<PGNResult: \"0-1\">", 
		"<PGNResult: \"*\">", PyUnicode_FromString)
#define MAKE_RES_GETTER_ENTRY(field) {#field , PyPGNResult_ ## field, NULL, NULL}

static PyGetSetDef PyPGNResult_getset[] = {
	MAKE_RES_GETTER_ENTRY(winner),	
	MAKE_RES_GETTER_ENTRY(is_unknown),	
	MAKE_RES_GETTER_ENTRY(is_draw),
	{NULL}
};



#define MAKE_RESULT_CONSTRUCTOR(NAME, VAL)\
	static PyObject * PyPGNResult_make_##NAME(PyObject *self, PyObject *Py_UNUSED(args)){\
		return PyPGNResult_make(VAL);\
	}\


MAKE_RESULT_CONSTRUCTOR(draw, DRAW_RES)
MAKE_RESULT_CONSTRUCTOR(white, WHITE_RES)
MAKE_RESULT_CONSTRUCTOR(black, BLACK_RES)
MAKE_RESULT_CONSTRUCTOR(unknown, UNK_RES)


static PyObject *PyPGNResult_from_str(PyObject *self, PyObject *arg) {
	if (!PyTypeCheck("str", arg, &PyUnicode_Type)) return NULL;
	const char *str = PyUnicode_AsUTF8AndSize(arg, NULL);
	if (!str) return NULL;
	if (!strcmp(str, "1-0")) return PyPGNResult_make(WHITE_RES);
	if (!strcmp(str, "0-1")) return PyPGNResult_make(BLACK_RES);
	if (!strcmp(str, "1/2-1/2")) return PyPGNResult_make(DRAW_RES);
	else return PyPGNResult_make(UNK_RES);
}


#define PGN_RES_METHOD(FIELD) {#FIELD, PyPGNResult_make_ ## FIELD, METH_STATIC | METH_NOARGS, NULL}

static PyMethodDef PyPGNResult_methods[] = {
	//PGN_RES_METHOD(draw),
	//PGN_RES_METHOD(white),
	//PGN_RES_METHOD(black),
	//PGN_RES_METHOD(unknown),
	{"from_str", PyPGNResult_from_str, METH_STATIC | METH_O, NULL},
	{NULL, NULL, 0, NULL},
};

static PyTypeObject PyPGNResultType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.pgn.PGNResult",
	.tp_basicsize = sizeof(PyPGNResultObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_str = PyPGNResult_to_str,	
	.tp_repr = PyPGNResult_repr,	
	.tp_getset = PyPGNResult_getset,
	.tp_methods = PyPGNResult_methods
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

static pgn_game_t *PyPGNGame_get(PyObject *self){
	return ((PyPGNGameObject *)self)->game;
}

static PyObject *PyPGNGame_Alloc() {
	PyPGNGameObject *obj = PyObject_New(PyPGNGameObject, &PyPGNGameType);
	pgn_validate(obj);
	obj->game = PyMem_RawMalloc(sizeof(pgn_game_t));
	pgn_validate(obj->game);
	obj->game->moves = PyMem_RawMalloc(600 * sizeof(move_t));
	pgn_validate(obj->game->moves);
	obj->game->raw_tags = NULL;
	obj->game->date = unknown_date();
	/*
	pgn_tag_section_t *tags = PyMem_RawMalloc(sizeof(pgn_tag_section_t));
	pgn_validate(tags);
	tags->event = PyMem_RawMalloc(255);
	tags->site= PyMem_RawMalloc(255);
	tags->round = PyMem_RawMalloc(255);
	tags->white_player = PyMem_RawMalloc(255);
	tags->black_player = PyMem_RawMalloc(255);
	obj->game->tags = tags;
	*/
	obj->game->starting_board = PyMem_RawMalloc(sizeof(full_board_t));
	obj->game->starting_board->position = PyMem_RawMalloc(sizeof(position_t));
	return (PyObject *)obj;
}


static void PyPGNGame_Dealloc(PyObject *self) {
	PyPGNGameObject *game = (PyPGNGameObject *)self;
	/*	
	pgn_tag_section_t *tags = game->game->tags;
	PyMem_RawFree(tags->event);
	PyMem_RawFree(tags->site);
	PyMem_RawFree(game->game->starting_board->position);
	PyMem_RawFree(game->game->starting_board);
	PyMem_RawFree(tags->round);
	PyMem_RawFree(tags->white_player);
	PyMem_RawFree(tags->black_player);
	*/
	dict_t *raw_tags = game->game->raw_tags;
	if (raw_tags){
		char **tags = (char **)dict_values(raw_tags);
		for (int i = 0; i < raw_tags->length; i++){
			free(tags[i]);
		}
		dict_free(raw_tags);
	}
	PyMem_RawFree(game->game->moves);
	PyMem_RawFree(game->game);
	PyGeneric_Dealloc(self);
}	


static PyObject* PyUnicode_FromStripped(char *str){
	if (str[0] == '"') {
		char buff[255];
		strcpy(buff, str);
		buff[strlen(str) - 1] = 0;
		return PyUnicode_FromString(buff + 1);
	}
	else {
		return PyUnicode_FromString(str);
	}
}

#define PGN_MAKE_GETTER(field,to_py_obj) static PyObject *PyPGN_ ## field (PyObject *self, void *closure){\
	PyPGNGameObject *game = (PyPGNGameObject *)self;\
	PyObject *obj = to_py_obj(game->game->tags->field);\
	if (!obj){ return NULL; } return obj;}

#define PGN_MAKE_GETTER_STR(field, str)\
static PyObject *PyPGN_ ## field (PyObject *self, void *closure){\
	PyPGNGameObject *game = (PyPGNGameObject *)self;\
	char *val = dict_lookup(game->game->raw_tags, str);\
	if (!val) return Py_None;\
	PyObject *py_str = PyUnicode_FromStripped(val);\
	if (!py_str){\
		PyErr_Clear();\
		return Py_None;\
	}\
	return py_str;\
}\



#define PGN_MAKE_GETTER_FIELD(field, to_py_obj)\
	static PyObject *PyPGN_ ## field (PyObject *self, void *closure){\
		PyPGNGameObject *game = (PyPGNGameObject *)self;\
		PyObject *obj = to_py_obj(game->game->field);\
		if (!obj){\
			return NULL;\
		} return obj;\
	}\

#define DATE_TUPLE_SET(index, known, val) if (known)\
	PyTuple_SET_ITEM(tuple, index, PyLong_FromUnsignedLong(val));\
	else {\
		PyObject *tmp = Py_None;\
		Py_INCREF(tmp);\
		PyTuple_SET_ITEM(tuple, index, tmp);\
	}\

/*
static PyObject *PyObject_from_date(date_t date) {
	PyObject *tuple = PyTuple_New(3);
	if (!tuple) return NULL;
	DATE_TUPLE_SET(0, date.known_year, date.year);	
	DATE_TUPLE_SET(1, date.known_month, date.month);	
	DATE_TUPLE_SET(2, date.known_day, date.day);	
	return tuple;
}
*/

PGN_MAKE_GETTER_STR(event, "Event")
PGN_MAKE_GETTER_STR(site, "Site")
PGN_MAKE_GETTER_STR(round, "Round")
PGN_MAKE_GETTER_STR(black_player, "Black")
PGN_MAKE_GETTER_STR(white_player, "White")

PGN_MAKE_GETTER_FIELD(date,PyPGNDate_make)
PGN_MAKE_GETTER_FIELD(result,PyPGNResult_make)
PGN_MAKE_GETTER_FIELD(starting_board,PyBoard_Wrap)

static PyObject *PyPGN_moves(PyObject *self, void *clousre){
	PyPGNGameObject *game = (PyPGNGameObject *)self;
	move_t *moves = game->game->moves;
	size_t count = game->game->count;
	PyObject* list = PyList_New(count);
	if (!list){
		PyErr_SetString(PyExc_MemoryError, "Could not allocate moves list");
		return NULL;
	}
	for (int i = 0; i < count; i++) {
		PyObject *move_obj = PyMove_make(moves[i]);
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
	return list;
}



static PyObject *PyPGNGame_getitem(PyObject *self, PyObject *index) {
	const char *str = PyUnicode_AsUTF8AndSize(index, NULL);
	if (!str) return NULL;
	char *value = dict_lookup(PyPGNGame_get(self)->raw_tags, str);
	if (!value) Py_RETURN_NONE;
	else return PyUnicode_FromStripped(value);
}



static PyMappingMethods PyPGNGameAsMapping = {
	.mp_subscript = PyPGNGame_getitem,
	//.mp_ass_subscript = PyBitboard_setitem,
	//.mp_length = PyBitboard_len,
};



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
		MAKE_GETTER_ENTRY(starting_board),
		{NULL}
};



static PyTypeObject PyPGNGameType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.pgn.PGNGame",
	.tp_basicsize = sizeof(PyPGNGameObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_dealloc = PyPGNGame_Dealloc,	
	.tp_getset = PyPGNGame_getset,
	.tp_as_mapping = &PyPGNGameAsMapping
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
	FILE *file = fopen(path, "r+");
	if (!file) {
		PyErr_Format(PyExc_FileNotFoundError, 
				"Could not find PGN file with path `%s`", path);
		return NULL;
	}
	PyPGNFileObject *self = PyObject_New(PyPGNFileObject, &PyPGNFileType);
	if (!self){
	 	fclose(file);
		return NULL;
	}
	self->pgnf.ctx = start_context(path, ";[].*()<>", "\"\"{}", '\\');
	self->pgnf.file = file;	
	return (PyObject *)self;
}

static PyObject *PyPGNFile_close(PyObject *self, PyObject *Py_UNUSED(args)){
	PyPGNFileObject *obj = (PyPGNFileObject *)self; 
	if (obj->pgnf.file) {
		fclose(obj->pgnf.file);	
		end_context(obj->pgnf.ctx);		
		obj->pgnf.file = NULL;
	}
	Py_RETURN_NONE;
}

static PyObject *PyPGNFile_enter(PyObject *self, PyObject *Py_UNUSED(args)){
	Py_INCREF(self);
	return self;
}

static PyObject *PyPGNFile_exit(PyObject *self, PyObject *args) {
	PyPGNFile_close(self, Py_None);
	Py_RETURN_NONE;
}

static PyObject *PyPGNFile_is_open(PyObject *self, PyObject *Py_UNUSED(args)) {
	PyPGNFileObject *obj = (PyPGNFileObject *)self; 
	return obj->pgnf.file ? Py_True : Py_False;
}

static PyObject *PyPGNFile_read_next_game(PyObject *self, PyObject *Py_UNUSED(args)){
	PyPGNFileObject *obj = (PyPGNFileObject *)self; 
	PyPGNGameObject *game = (PyPGNGameObject *)PyPGNGame_Alloc();
	if (!game) return NULL;
	char err[500] = {0};
	int res = next_pgn(&obj->pgnf, game->game, err);
	switch (res) {
		case 0: {
			return (PyObject *)game;
		}
		case 1: {
			Py_DECREF(game);
			PyErr_SetString(PyExc_ValueError, err);
			return NULL;
		}
		default: Py_RETURN_NONE;
	}
}



static PyMethodDef PyPGNFile_methods[] = { 
    {"next_game", PyPGNFile_read_next_game, METH_NOARGS, NULL}, 
		{"open", PyPGNFile_open, METH_O | METH_STATIC, NULL},
		{"is_open", PyPGNFile_is_open, METH_NOARGS, NULL},
		{"close", PyPGNFile_close, METH_NOARGS, NULL},
		{"__enter__", PyPGNFile_enter, METH_NOARGS, NULL},
		{"__exit__", PyPGNFile_exit, METH_VARARGS, NULL},
		{NULL, NULL, 0, NULL}
};

static PyTypeObject PyPGNFileType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.pgn.PGNFile",
	.tp_basicsize = sizeof(PyPGNFileObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_dealloc = PyGeneric_Dealloc,	
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


#define DEBUG_INIT 0
#define DEBUG_INIT_PRINT(msg) (DEBUG_INIT && printf(msg))

#define VALIDATE(pt) if (!pt) {DEBUG_INIT_PRINT("Validating " #pt "\n"); Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL;} 
#define ADD_OBJ(name, obj) if (PyModule_AddObjectRef(m, name, \
			(PyObject *)obj) < 0) { Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL; }

#define ADD_UTIL(name, obj) if (PyModule_AddObjectRef(utils, name, \
			(PyObject *)obj) < 0) { Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL; }



#define ADD_TYPE(name, type) if (PyType_Ready(&type) < 0) return NULL; \
	ADD_OBJ(name, &type);



#define ADD_PGN(name, obj) if (PyModule_AddObjectRef(pgn, name, \
			(PyObject *)obj) < 0) { Py_DECREF(m); Py_DECREF(utils); Py_DECREF(pgn); return NULL; }



#define READY_TYPE(TYPE) if (PyType_Ready(&TYPE) < 0){ fprintf(stderr, "Could not ready " #TYPE "\n"); return NULL;} else DEBUG_INIT_PRINT(#TYPE " ready\n")

PyMODINIT_FUNC PyInit__core(void) {
		READY_TYPE(PyColorType);
    READY_TYPE(PySquareType);
		READY_TYPE(PyPieceTypeType);
		READY_TYPE(PyPieceType);
		READY_TYPE(PyMoveType);
		READY_TYPE(PyBitboardType);
		READY_TYPE(PyPGNFileType);
		READY_TYPE(PyPGNGameType);
		READY_TYPE(PyPGNResultType);
		READY_TYPE(PyPGNDateType);
		READY_TYPE(PyCastlingTypeType);
		READY_TYPE(PyCastlingRightsType);
		READY_TYPE(PyColorSchemeType);
		READY_TYPE(PyBoardStatusType);
	  	
		//initstate(time(NULL), rand_state, 256);
		PyMoves_prep();
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

		ADD_OBJ("pgn", pgn);
		VALIDATE(PySquares_init());
		VALIDATE(PyPieceTypes_init());
		VALIDATE(PyColors_init());
		VALIDATE(PyPGNResults_init());
		VALIDATE(PyCastlingRights_init());
		PyModule_AddFunctions(utils, PyUtilsMethods);
		ADD_PGN("PGNGame", &PyPGNGameType);
		ADD_PGN("PGNDate", &PyPGNDateType);
		ADD_PGN("PGNFile", &PyPGNFileType);
		ADD_PGN("PGNResult", &PyPGNResultType);
		ADD_PGN("WHITE_WON", PyPGNResult_make(WHITE_RES));
		ADD_PGN("BLACK_WON", PyPGNResult_make(BLACK_RES));
		ADD_PGN("DRAW_RESULT", PyPGNResult_make(DRAW_RES));
		ADD_PGN("UNKNOWN_RESULT", PyPGNResult_make(UNK_RES));
		ADD_OBJ("utils", utils);
		ADD_OBJ("Bitboard", &PyBitboardType);
		ADD_OBJ("Color", &PyColorType);
		ADD_OBJ("Square", &PySquareType);
		ADD_OBJ("PieceType", &PyPieceTypeType);
		ADD_OBJ("Piece", &PyPieceType);
		ADD_OBJ("CastlingType", &PyCastlingTypeType);
		ADD_OBJ("CastlingRights", &PyCastlingRightsType);
		ADD_OBJ("Move", &PyMoveType);
		ADD_OBJ("BoardStatus", &PyBoardStatusType);
		
		VALIDATE(PyColorScheme_predefined());
		PyObject *board_dict = PyDict_New();
		PyDict_SetItemString(board_dict, "LAGOON", LAGOON);
		PyDict_SetItemString(board_dict, "OAK", OAK);
		PyDict_SetItemString(board_dict, "SLATE", SLATE);
		PyDict_SetItemString(board_dict, "GREEN", GREEN);
		PyDict_SetItemString(board_dict, "WALNUT", WALNUT);
		PyDict_SetItemString(board_dict, "CLAY", CLAY);
		PyDict_SetItemString(board_dict, "ROSE", ROSE);
		PyDict_SetItemString(board_dict, "STEEL", STEEL);
		PyDict_SetItemString(board_dict, "STEEL", STEEL);
		PyDict_SetItemString(board_dict, "ColorScheme", (PyObject *)&PyColorSchemeType);
		PyBoardType.tp_dict = board_dict; 
		VALIDATE(!(PyType_Ready(&PyBoardType) < 0))
		ADD_OBJ("Board", &PyBoardType);
		
		WhiteKingside = PyCastlingType_new(WHITE_KINGSIDE);
		VALIDATE(WhiteKingside);	
		BlackKingside = PyCastlingType_new(BLACK_KINGSIDE);
		VALIDATE(BlackKingside);	
		WhiteQueenside= PyCastlingType_new(WHITE_QUEENSIDE);
		VALIDATE(WhiteQueenside);	
		BlackQueenside = PyCastlingType_new(BLACK_QUEENSIDE);
		VALIDATE(BlackQueenside);
		ADD_OBJ("WHITE_KINGSIDE", WhiteKingside);		
		ADD_OBJ("WHITE_QUEENSIDE", WhiteQueenside);		
		ADD_OBJ("BLACK_KINGSIDE", BlackKingside);		
		ADD_OBJ("BLACK_QUEENSIDE", BlackQueenside);		
		
			
		PyObject *WHITE = PyColor_make(WHITE_VAL);
		VALIDATE(WHITE);
		PyObject *BLACK = PyColor_make(BLACK_VAL);
		VALIDATE(BLACK);
		ADD_OBJ("WHITE", WHITE);
		ADD_OBJ("BLACK", BLACK);
		PyObject *Squares_List = PyList_New(0);
		VALIDATE(Squares_List);
		PyObject *FlippedSquares_List = PyList_New(0);
		VALIDATE(FlippedSquares_List);
		for (square_t sq = A1; sq <= H8; sq++) {
			char buffer[3];
			serialize_sqr_caps(sq, buffer);
			PyObject *PySquare = PySquare_make(sq);
			ADD_OBJ(buffer, PySquare);
			PyList_Append(Squares_List, PySquare);
		}
		for (int i = 0; i < 64; i++){
			PyObject *sq = PySquare_make(fen_index_to_square(i));
			PyList_Append(FlippedSquares_List, sq);
		}
		ADD_OBJ("SQUARES", Squares_List);
		ADD_OBJ("SQUARES_FLIPPED", FlippedSquares_List);
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
		PyObject *Ranks_List = PyList_New(0);
		VALIDATE(Ranks_List);
		for (int rank_num = 1; rank_num < 9; rank_num++) {
			char buffer[7];
			sprintf(buffer, "RANK_%d", rank_num);
			PyObject *RANK = (PyObject *)PyBitboard_make(cur_rank);
			VALIDATE(RANK);
			ADD_OBJ(buffer, RANK);
			cur_rank = SAFE_ABOVE_BB(cur_rank);
			PyList_Append(Ranks_List, RANK);
		}
		ADD_OBJ("RANKS", Ranks_List);

		PyObject *FULL_BB_OBJ = (PyObject *)PyBitboard_make(FULL_BB);
		VALIDATE(FULL_BB_OBJ);
		ADD_OBJ("FULL_BB", FULL_BB_OBJ);
		bitboard_t cur_file = FILE_A;
		PyObject *EMPTY_BB_OBJ = (PyObject *)PyBitboard_make(0);
		VALIDATE(EMPTY_BB_OBJ);
		ADD_OBJ("EMPTY_BB", EMPTY_BB_OBJ);

		PyObject *LIGHT_BB_OBJ = (PyObject *)PyBitboard_make(LIGHT_SQ_BB);
		VALIDATE(LIGHT_BB_OBJ);
		ADD_OBJ("LIGHT_SQUARE_BB", LIGHT_BB_OBJ);
	
		PyObject *DARK_BB_OBJ = (PyObject *)PyBitboard_make(DARK_SQ_BB);
		VALIDATE(DARK_BB_OBJ);
		ADD_OBJ("DARK_SQUARE_BB", DARK_BB_OBJ);
	

		PyObject *Files_List = PyList_New(0);
		VALIDATE(Files_List);
		for (int file_num = 0; file_num < 8; file_num++) {
			char buffer[7];
			sprintf(buffer, "%c_FILE", 'A' + file_num);
			PyObject *FILEV= (PyObject *)PyBitboard_make(cur_file);
			VALIDATE(FILEV);
			ADD_OBJ(buffer, FILEV);
			cur_file= SAFE_RIGHT_BB(cur_file);
			PyList_Append(Files_List, FILEV);
		}

		ADD_OBJ("FILES", Files_List);
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

		VALIDATE(PyBoardStatus_make_all());
		VALIDATE(PyPiece_make_all());
		ADD_OBJ("CHECK", CHECK_OBJ);
		ADD_OBJ("MATE", MATE_OBJ);
		ADD_OBJ("INSUFFICIENT_MATERIAL", INSUFFICIENT_OBJ);
		ADD_OBJ("FIFTY_MOVE_TIMEOUT", FIFTY_OBJ);
		ADD_OBJ("SEVENTY_FIVE_MOVE_TIMEOUT", SEVENTY_FIVE_OBJ);
		ADD_OBJ("THREEFOLD_REPETITION", THREE_FOLD_OBJ);
		ADD_OBJ("FIVEFOLD_REPETITION", FIVE_FOLD_OBJ);

		ADD_OBJ("DRAW", DRAW_OBJ);
		ADD_OBJ("FORCED_DRAW", FORCED_DRAW_OBJ);
		ADD_OBJ("CHECKMATE", CHECKMATE_OBJ);
		ADD_OBJ("STALEMATE", STALEMATE_OBJ);
		
		PyCastlingRightsObject *ALL_CASTLING 
			= PyCastlingRights_make(FULL_CASTLING);
		VALIDATE(ALL_CASTLING);
		PyCastlingRightsObject *MT_CASTLING
			= PyCastlingRights_make(NO_CASTLING);
		ADD_OBJ("ALL_CASTLING", ALL_CASTLING);	
		ADD_OBJ("NO_CASTLING", MT_CASTLING);
		zobrist_table = create_zobrist_table();
		fill_zobrist_table(zobrist_table);
		return m;
}


