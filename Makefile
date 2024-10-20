build: ## build hugo source
	bunx --bun astro build

deploy: build ## send built files to webserver
	rsync --rsync-path="sudo rsync" -rvhe ssh --progress --delete ./dist/ tht@192.168.1.111:/var/www/pwned.page/

.PHONY: build deploy
