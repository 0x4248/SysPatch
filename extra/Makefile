# SPDX-License-Identifier: GPL-3.0
# SysPatch
# A simple tool to create and apply patches to a system.
#
# Makefile - Base makefile
# Copy this file to the root of the project and run `make` to generate the patch.
#
# Copyright (C) 2024 0x4248

SOURCE = src
PYTHON = python3
BUILD = build

all: clean init build

init:
	@mkdir -p $(BUILD)

build: 
	@$(PYTHON) syspatch/src/generatepatch.py  $(BUILD)

clean:
	@rm -rf $(BUILD)

deployment_server:
	@cd build && python3 -m http.server 4522

.PHONY: all build