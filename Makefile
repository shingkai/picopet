.PHONY: all build lint frontend backend clean help

all: build

help:
	@echo "PicoPet — root build targets"
	@echo ""
	@echo "  make build     Build both frontend and backend (lint gates both)"
	@echo "  make lint      Lint both frontend and backend, no build"
	@echo "  make frontend  Build frontend only"
	@echo "  make backend   Build backend only"
	@echo "  make clean     Clean both"

build: backend frontend

lint:
	$(MAKE) -C backend check
	cd frontend && npm run lint

frontend:
	cd frontend && npm run build

backend:
	$(MAKE) -C backend build

clean:
	$(MAKE) -C backend clean
	rm -rf frontend/dist frontend/node_modules
