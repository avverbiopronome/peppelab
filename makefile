## always remember. you need to escape dollar signs. everywhere.

FTPASSWORD := $(shell security find-internet-password -gs peppelab.altervista.org 2>&1 | grep "password" | sed 's/.*"\(.*\)"/\1/')

FTPOPTIONS = -q ignoremask='^\.|^a$$'

## The difference between _config and _config-local is one:
## _config-local disables any output compression, so compilation is
## much quicker

all: kill
	jekyll serve --detach --incremental --config _config.yml
	open 'http://0.0.0.0:4000'

kill:
	cp _sass/bootstrap/dist/js/bootstrap.min.js files/
	pkill -f jekyll || true

build: kill
	JEKYLL_ENV=production jekyll build --config _config.yml

upload: build
	@echo "uploading... "
	@ftpsync $(FTPOPTIONS) ./_site ftp://peppelab:$(FTPASSWORD)@ftp.peppelab.altervista.org// 

push: upload
	git push
	git push gitlab
