#!/usr/bin/env bash

docker run -it --rm --volume "$(pwd)/environment:/spec" php-fpm-7.1-alpine /spec/environment.sh php
