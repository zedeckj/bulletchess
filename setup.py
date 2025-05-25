from setuptools import Extension, setup
from pathlib import Path
import os
import sys
ROOT = Path(__file__).parent / "bulletchess"
print(ROOT)
SRC = ROOT / "src"
print(SRC)
import sysconfig

def relative_path(path) -> str:
    return "bulletchess/" + str(path.relative_to(ROOT))

source_files = [relative_path(p) for p in SRC.rglob("*.c")]
print(source_files)

py_paths = sysconfig.get_paths()

if sys.platform.startswith("win"):
    extra_compile_args=["O2", "/std:c17"]
else:
    extra_compile_args=["-O3", "-std=gnu17"],     

core = Extension(
    name = "bulletchess._core",
    sources = source_files, 
)

print(core)

setup(
    ext_modules = [core],
)

