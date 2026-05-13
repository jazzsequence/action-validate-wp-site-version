#!/bin/bash

set -euo pipefial
IFS=$'\n\t'

main() {
    export TERMINUS_HIDE_GIT_MODE_WARNING=1
    local CURRENT_WP_VERSION
    local INSTALLED_WP_VERSION
    local VERSION_COMPARE
    
    CURRENT_WP_VERSION=$(curl -s https://api.wordpress.org/core/version-check/1.7/ | jq -r '.offers[0].current')
    echo "Current WordPress Version: ${CURRENT_WP_VERSION}"
    
    if [ -z "${PANTHEON_SITE}" ]; then
        echo "PANTHEON_SITE is not defined. This action requires the site to be set in the action config."
        exit 1
    fi
    
    INSTALLED_WP_VERSION=$(terminus wp "${PANTHEON_SITE}.dev" -- core version)
    echo "Installed WordPress Version on ${PANTHEON_SITE}: ${INSTALLED_WP_VERSION}"
    
    VERSION_COMPARE=$(php -r "echo version_compare('${INSTALLED_WP_VERSION}', '${CURRENT_WP_VERSION}');")
    if [[ "${VERSION_COMPARE}" == "-1" ]]; then
        echo "Installed WordPress version (${INSTALLED_WP_VERSION}) is less than the current WordPress version (${CURRENT_WP_VERSION})"
        
        if [[ "${APPLY_UPSTREAM_UPDATES}" == 'true' ]]; then
            echo "Applying upstream updates..."
            terminus upstream:updates:apply
        else
            echo "Apply upstream updates not requested. Installed WordPress version is out of date. You should update WordPress. Exiting."
            exit 1
        fi
    fi
}

main
