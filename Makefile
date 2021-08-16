# Use bash instead of sh
SHELL := /usr/bin/env bash

.PHONY: bootstrap
bootstrap:
	@source scripts/0-bootstrap/bootstrap.sh

.PHONY: org
org:
	@source scripts/1-org/org.sh

.PHONY: env
env:
	@source scripts/2-environments/environments.sh

.PHONY: networks
networks:
	@source scripts/3-networks/networks.sh

.PHONY: projects
projects:
	@source scripts/4-projects/projects.sh

.PHONY: app-infra
app-infra:
	@source scripts/5-app-infra/app-infra.sh