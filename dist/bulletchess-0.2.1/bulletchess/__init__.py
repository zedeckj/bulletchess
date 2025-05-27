from importlib import import_module as _imp

_core = _imp("bulletchess._core")

globals().update(_core.__dict__)      

del _core, _imp
