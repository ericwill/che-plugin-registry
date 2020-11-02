#!/bin/bash
#
# Copyright (c) 2018-2020 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#

set -e

FILES_CHANGED=($(git diff --name-only -r $1 $2))
SIDECARS_TO_TEST=()
for i in "${FILES_CHANGED[@]}"
do
    if [[ $i == 'sidecars/'* ]]; then
        echo $i
        SIDECAR_NAME=$(echo $i | cut -d/ -f 2)
        if ! [[ " ${SIDECARS_TO_TEST[@]} " =~ " ${SIDECAR_NAME} " ]]; then
            SIDECARS_TO_TEST+=($SIDECAR_NAME)
            PLATFORMS=$(cat sidecars/$SIDECAR_NAME/PLATFORMS)
            # docker buildx build --platform $PLATFORMS sidecars/$SIDECAR_NAME/
            echo $SIDECAR_NAME
        fi
    fi
done