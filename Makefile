# SPDX-License-Identifier: GPL-3.0
# SysPatch
# A simple patching system for Linux
#
# Makefile
#
# Copyright (C) 2024 0x4248

SOURCE = src
PYTHON = python3
BUILD = build

all: build

build: 
	@echo "[ SYSPATCH ]\t Generating patch"
	@$(PYTHON) syspatch/src/generatepatch.py $(SOURCE) $(BUILD)

deployment_server:
	@echo "[ SYSPATCH ]\t Starting deployment server"
	@cd build && python3 -m http.server 4522

.PHONY: all build