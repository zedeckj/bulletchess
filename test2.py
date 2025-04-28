import bulletchess, inspect, pathlib, sys
print("file exists:", pathlib.Path(bulletchess.__file__))
print("Stub exists:", pathlib.Path(bulletchess.__file__).with_suffix(".pyi").exists())
print("py.typed   :", (pathlib.Path(bulletchess.__file__).parent / "py.typed").exists())
