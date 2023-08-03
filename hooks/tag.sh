#!/bin/bash

set -xeuo pipefail

: '
This function checks if a given tag exists in a git repository.

Usage:
    check_git_tag /path/to/repository v1.0.0
'
function check_git_tag() {
    repository_path="$1"
    tag="$2"
    
    # Change directory to the repository path
    cd "$repository_path" || exit
    
    # Fetch all tags from remote repository
    git fetch --tags --quiet
    
    # Check if the given tag exists
    if git rev-parse "$tag" >/dev/null 2>&1; then
        echo "Tag '$tag' exists in the repository"
        echo "Exiting with code 1"
        exit 1
    else
        echo "Tag '$tag' does not exist in the repository. Create"
    fi
}

env 

# set default suffix
# TODO: check if the suffix is defaulted from the plugin config 
if [[ -z "$BUILDKITE_PLUGIN_TERRAFORM_PUBLISH_MODULE_SUFFIX" ]]; then
  BUILDKITE_PLUGIN_TERRAFORM_PUBLISH_MODULE_SUFFIX="-dev"
fi
SUFFIX=$BUILDKITE_PLUGIN_TERRAFORM_PUBLISH_MODULE_SUFFIX

# Get the tag from the buildkite agent
# This is the input from the user
TAG=$(buildkite-agent meta-data get tag)

# BUILDKITE_PIPELINE_DEFAULT_BRANCH - the main branch of the repo 
# BUILDKITE_BRANCH - the branch that is being built

# Ensure that non master / main branch tag contains suffix
if [[ "${BUILDKITE_BRANCH}" != "${BUILDKITE_PIPELINE_DEFAULT_BRANCH}" ]]; then
  if [[ "$TAG" == *"$SUFFIX"* ]]; then
    echo "TAG contains SUFFIX"
  else
    echo "Adding SUFFIX to TAG"
    TAG="$TAG$SUFFIX"
  fi
fi

check_git_tag . "$TAG"

git tag "$TAG"
git push origin "$TAG"
