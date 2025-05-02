#ifndef BULLETCHESSHEADER
#define BULLETCHESSHEADER
#include "include/Python.h"
#include "apply.h"


static void PyTypeErr(char * expected, PyObject *obj);
static bool PyTypeCheck(char *expected, PyObject *obj, PyTypeObject *type);


static PyTypeObject PySquareType;

static PyTypeObject PyPieceTypeType;


static PyTypeObject PyColorType;


static PyTypeObject PyPieceType;


static PyTypeObject PyMoveType;
#endif
