SHELL := /bin/bash


.PHONY: all clean test

all:
	 source venv/bin/activate && \
	 python3.13 -X dev setup.py build_ext && \
	 pip install .

test:
	cc -fsanitize=address -fno-omit-frame-pointer -Wno-format-security -static-libsan bulletchess/src/internal/tokenizer/*.c bulletchess/src/internal/date-parsing/*.c  bulletchess/src/internal/dictionary/*.c bulletchess/src/internal/*.c ctest/ctest.c -o ctest

clean:
	 rm -rf build *.so **/*.so
	 rm -rf build dist *.egg-info

