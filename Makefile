.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

compile: ## sbt compile
	sbt update clean compile

test: ## sbt test
	sbt update clean test

jar: ## sbt assembly
	sbt update clean scalafmt test assembly

run-sbt: ## sbt run
	sbt update clean run

run-skaffold: ## run jar with skaffold (watch jar)
	skaffold dev
