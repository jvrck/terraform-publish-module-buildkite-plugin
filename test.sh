#!/bin/bash

set -eu

TEST=[{\"github.com/jvrck/terraform-publish-module-buildkite-plugin#release-0.0.1\":null},{\"github.com/buildkite-plugins/docker-buildkite-plugin#v5.8.0\":{\"image\":\"alpine:latest\"}}]

echo "$TEST"

IFS=','
for item in "${TEST[@]}"; do
  echo "Item: $item"
  if [[ $item =~ 'image' ]]; then
    echo "Image: ${item##*\"}:${item##*\"}"
  fi
done