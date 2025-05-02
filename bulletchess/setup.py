from pathlib import Path
from setuptools import setup, Extension

ROOT = Path(__file__).resolve().parent
SRC  = ROOT / "src"
c_sources = [str(p) for p in SRC.rglob("*.c")]

bulletchess_module = Extension(
    "bulletchess._core",
    sources=c_sources,
    include_dirs=[str(SRC)],
    extra_compile_args=["-O3"],
)

setup(
    name="bulletchess",
    version="0.1.0",
    description="Bullet-speed chess core in C",
    ext_modules=[bulletchess_module],
    py_modules=[],
    package_data={"bulletchess": ["*.pyi", "**/*.pyi", "py.typed"]},
    include_package_data=True,           
    zip_safe=False,                     
)


