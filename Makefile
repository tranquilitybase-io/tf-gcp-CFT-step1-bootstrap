# Use bash instead of sh
SHELL := /usr/bin/env bash

.PHONY: bootstrap
bootstrap:
	@source scripts/0-bootstrap/bootstrap.sh
