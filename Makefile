SHELL := /bin/bash
.DEFAULT_GOAL := help

help:
	@make2help $(MAKEFILE_LIST)

## Note that the API server must
## also be running.
start:
	@gopherjs -m -v serve --http :3000 github.com/tj/docs/client

## Start the API server.
api:
	@go run server/cmd/api/api.go

## Display dependency graph.
deps:
	@godepgraph github.com/tj/docs/client | dot -Tsvg | browser

## Display size of dependencies.
##- Any comment preceded by a dash is omitted.
size:
	@gopherjs build client/*.go -m -o /tmp/out.js
	@du -h /tmp/out.js
	@gopher-count /tmp/out.js | sort -nr

.PHONY: start api deps size help
