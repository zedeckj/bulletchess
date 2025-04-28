#include "include/Python.h"
#include "apply.h" 
#include "fen.h"

/* Move CLASS */
/*
typedef struct {
	PyObject_HEAD
	move_t move;	
} PyMoveObject;

static PyTypeObject PyMoveType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Move",
	.tp_basicsize = sizeof(PyMoveObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT,
  .tp_new = PyType_GenericNew
};


static PyMoveObject* PyMove_alloc(move_t move) {
	PyMoveObject *self = PyObject_New(PyMoveObject, &PyMoveType);
	if (!self) return NULL;
  self->move = move;
  return self;
}
*/

/* Board CLASS */

typedef struct {
	PyObject_HEAD
	full_board_t *board;
} PyBoardObject;


static PyTypeObject PyBoardType;

static PyBoardObject* PyBoard_alloc() {
	PyBoardObject *self = PyObject_New(PyBoardObject, &PyBoardType);
	if (!self) return NULL;
  self->board = PyMem_Malloc(sizeof(full_board_t));
	if (!self->board) return NULL;
	self->board->position = PyMem_Malloc(sizeof(position_t));
	if (!self->board->position) return NULL;
	return self;
}

static void PyBoard_dealloc(PyBoardObject *self) {
		PyMem_Free(self->board->position);
		PyMem_Free(self->board);
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
		return NULL;
	}
	return (PyObject *)board;
}

static PyObject *PyBoard_from_fen(PyObject *self, PyObject *args) {
	const char *fen = PyUnicode_AsUTF8AndSize(args, NULL);
	if (!fen) return NULL;
	return PyBoard_from_fen_str(fen);
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
	  const char *fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
		char *err = parse_fen(fen, PyBoard_board(self)); 
		if (err) {
			PyErr_SetString(PyExc_ValueError,err);	
			return -1;
		}			
    return 0;
}


static PyObject *
PyBoard_to_fen(PyObject *self, PyObject *Py_UNUSED(args)){
	char fen_buffer[128];
	make_fen(PyBoard_board(self), fen_buffer);
	return PyUnicode_FromString(fen_buffer);
}

/*
static PyMemberDef PyBoard_members[] = {
    {"halfmove_clock", T_INT,offsetof(PyBoardObject, ply), 0, NULL}
    {"fullmove_number", T_INT, offsetof(PyBoardObject, ply), 0, NULL}
		{NULL}
};
*/

static PyMethodDef PyBoard_methods[] = { 
    {   
        "from_fen", PyBoard_from_fen, METH_O | METH_STATIC, NULL
		},  
    {   
        "fen", PyBoard_to_fen, METH_NOARGS, NULL
		},  
    {NULL, NULL, 0, NULL}
};


static Py

static PyTypeObject PyBoardType = {
	.ob_base = PyVarObject_HEAD_INIT(NULL, 0)
	.tp_name = "bulletchess.Board",
	.tp_basicsize = sizeof(PyBoardObject),
  .tp_itemsize = 0,
  .tp_flags = Py_TPFLAGS_DEFAULT, 
	.tp_dealloc = (destructor)PyBoard_dealloc,
	.tp_alloc = (allocfunc)PyBoard_alloc,
	.tp_new = PyType_GenericNew,
	.tp_methods = PyBoard_methods,
	.tp_init = Board_init
};



// Module definition
// The arguments of this structure tell Python what to call your extension,
// what it's methods are and where to look for it's method definitions
static struct PyModuleDef bulletchess_definition = { 
    PyModuleDef_HEAD_INIT,
    "bulletchess",
    "bulletchess docs"
		-1, 
};



// Module initialization
// Python calls this function when importing your extension. It is important
// that this function is named PyInit_[[your_module_name]] exactly, and matches
// the name keyword argument in setup.py's setup() call.
PyMODINIT_FUNC PyInit_bulletchess(void) {
    if (PyType_Ready(&PyBoardType) < 0)
        return NULL;

		PyObject *m = PyModule_Create(&bulletchess_definition);
		if (PyModule_AddObjectRef(m, "Board", 
					(PyObject *) &PyBoardType) < 0) {
    	Py_DECREF(m);
    	return NULL;
		}
		return m;
}

