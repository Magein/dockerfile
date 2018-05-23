#!/usr/bin/env bash

. ./config.sh

docker pull "$nginx_registry"

docker pull "$php_registry"