#ifndef BULLETCHESSHEADER
#define BULLETCHESSHEADER
#include "internal/all.h"
#include <Python.h>
#include <limits.h>
static void PyTypeErr(char * expected, PyObject *obj);
static bool PyTypeCheck(char *expected, PyObject *obj, PyTypeObject *type);

static PyTypeObject PyBitboardType;
static PyTypeObject PySquareType;
static PyTypeObject PyBoardType;
static PyTypeObject PyPieceTypeType;
static PyTypeObject PyColorType;
static PyTypeObject PyPieceType;
static PyTypeObject PyMoveType;


static inline bitboard_t PyBitboard_get(PyObject *self);
static PyObject *PyBitboard_make(bitboard_t bitboard);
#endif
