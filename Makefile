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

VERSION_MAJOR = 1
VERSION_MINOR = 0
VERSION_PATCH = 0
VERSION_EXTRA = alpha
VERSION = $(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_PATCH)-$(VERSION_EXTRA)

all: clean init genversion build

init:
	@echo "[ SYSPATCH ]\t Initializing"
	@mkdir -p $(BUILD)
	@touch build.txt
	@echo $$(($$(cat build.txt) + 1)) > build.txt

genversion:
	@echo "[ SYSPATCH ]\t Generating version"
	@mkdir -p $(BUILD)/tmp
	@echo $(VERSION) > $(BUILD)/tmp/version
	@git rev-parse HEAD > $(BUILD)/tmp/commit

build: 
	@echo "[ SYSPATCH ]\t Generating patch"
	@$(PYTHON) syspatch/src/generatepatch.py $(SOURCE) $(BUILD)

clean:
	@echo "[ SYSPATCH ]\t Cleaning"
	@rm -rf $(BUILD)

deployment_server:
	@echo "[ SYSPATCH ]\t Starting deployment server"
	@cd build && python3 -m http.server 4522

.PHONY: all build