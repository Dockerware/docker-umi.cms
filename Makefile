duild:
	cd image && IMAGE_NAME=php-fpm-7.1-alpine ../hooks/build

.PHONY: test
test: test-static-analysis test-environment
		
test-environment: duild
	cd test && ./run.sh

test-static-analysis:
	shellcheck --exclude=SC2148 Makefile
	shellcheck hooks/*
	shellcheck test/*.sh
	shellcheck test/**/*.sh
