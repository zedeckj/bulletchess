from pathlib import Path
from setuptools import Extension, setup, find_namespace_packages
import sys
import sysconfig

ROOT = Path(__file__).parent / "bulletchess"      # bulletchess/
SRC  = ROOT / "src"                               # bulletchess/src/

def rel(p: Path) -> str:
    return "bulletchess/" + str(p.relative_to(ROOT))

# All C & H sources for the build_ext step
c_sources  = [rel(p) for p in SRC.rglob("*.c") if "python-headers" not in rel(p)]
h_headers  = [rel(p) for p in SRC.rglob("*.h") if "python-headers" not in rel(p)]

extra_compile_args = (
    ["/O2", "/std:c17", "/utf-8"] if sys.platform.startswith("win") else ["-O3", "-std=gnu17"]
)

core = Extension(
    name="bulletchess._core",
    sources=c_sources,
    include_dirs=["bulletchess"],
    depends=h_headers,
    extra_compile_args=extra_compile_args,
)

packages = ["bulletchess"]

setup(
    ext_modules=[core],
    packages=packages,
    package_dir={"bulletchess": "bulletchess"},
    package_data = {
        "bulletchess": [
            "*.pyi", "py.typed",
            "utils/*.pyi",
            "pgn/*.pyi"
        ],
    },
    exclude_package_data={"bulletchess": ["**/*.c", "**/*.h"]}
)

