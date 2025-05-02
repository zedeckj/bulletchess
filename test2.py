import sys, pkgutil
print([m.module_finder for m in pkgutil.iter_modules() if m.name=='bulletchess'])