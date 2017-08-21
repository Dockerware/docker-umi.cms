#!/usr/bin/env sh

SPEC_NAME=${1}

curl -fsSL https://goss.rocks/install | sh
goss --gossfile "/spec/environment_${SPEC_NAME}.yaml" validate
