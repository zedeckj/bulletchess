from setuptools import Extension, setup
from pathlib import Path
import os

ROOT = Path(__file__).parent / "bulletchess"
print(ROOT)
SRC = ROOT / "src"
print(SRC)

def relative_path(path) -> str:
    return "bulletchess/" + str(path.relative_to(ROOT))

source_files = [relative_path(p) for p in SRC.rglob("*.c")]
print(source_files)

core = Extension(
    name = "bulletchess._core",
    sources = source_files, 
    extra_compile_args=["-O3"],     
)

setup(
    ext_modules = [core],
)

