
from importlib import resources
from pathlib import Path

_pkg_root = Path(__file__).resolve().parent.parent.parent
DATA_DIR = _pkg_root / "data"

def data_file(name: str) -> str:
    return str(DATA_DIR / name)
