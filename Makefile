.PHONY: all
all: prettier ## Make all

.PHONY: prettier
prettier: ## Format markdown files
	npx prettier --write blog/*.md
