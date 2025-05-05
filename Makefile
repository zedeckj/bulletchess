SHELL := /bin/bash


.PHONY: all clean


#
# ---# ---------------------------------------------------------------------------
# Regular build (no sanitizer) – what you already had
all:
	 source venv/bin/activate && \
	 python3.13 -X dev bulletchess/setup.py build_ext --inplace


# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Run a script under ASan (change script name as needed)
# Remember: system /usr/bin/python3 is SIP‑protected – use a Homebrew or
# self‑built interpreter that lives outside /usr/bin.
run-asan: asan
	 source venv/bin/activate && \
	 DYLD_INSERT_LIBRARIES="$(ASAN_RT)" \
	 DYLD_FORCE_FLAT_NAMESPACE=1 \
	 ASAN_OPTIONS="detect_leaks=1,abort_on_error=1,log_path=asan" \
	 python3.13 -X dev your_crasher.py

# ---------------------------------------------------------------------------
clean:
	 rm -rf build *.so **/*.so
# ---------------------------------------------------------------------------

