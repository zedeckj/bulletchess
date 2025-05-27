#ifndef BULLETCHESSHEADER
#define BULLETCHESSHEADER
#include "internal/all.h"
#include <Python.h>
//#include "python-headers/Python.h"
#include <limits.h>

static void PyTypeErr(char * expected, PyObject *obj);
static bool PyTypeCheck(char *expected, PyObject *obj, PyTypeObject *type);

static PyTypeObject PySquareType;
static PyTypeObject PyBoardType;
static PyTypeObject PyPieceTypeType;
static PyTypeObject PyColorType;
static PyTypeObject PyPieceType;
static PyTypeObject PyMoveType;


static PyObject *PyBitboard_make(bitboard_t bitboard);
#endif
