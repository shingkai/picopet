.PHONY: all build check fmt fmt-check lint test run clean

CARGO ?= cargo

all: build

# The canonical build target. Format check and clippy run first;
# either failing blocks the build.
build: fmt-check lint
	$(CARGO) build --release

check: fmt-check lint

fmt:
	$(CARGO) fmt --all

fmt-check:
	$(CARGO) fmt --all -- --check

lint:
	$(CARGO) clippy --all-targets --all-features -- -D warnings

test: fmt-check lint
	$(CARGO) test --all-features

run:
	$(CARGO) run

clean:
	$(CARGO) clean
