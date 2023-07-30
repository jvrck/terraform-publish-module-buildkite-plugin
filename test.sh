#!/bin/bash

set -eu

function format_url() {
  local url=$1
  url=${url//\//-}   # Replace '/' with '-'
  url=${url//\./-}   # Replace '.' with '-'
  url=${url//#/-}    # Replace '#' with '-'
  echo $url
}


TEST=[{\"github.com/jvrck/terraform-publish-module-buildkite-plugin#release-0.0.1\":null},{\"github.com/buildkite-plugins/docker-buildkite-plugin#v5.8.0\":{\"image\":\"alpine:latest\"}}]
echo "$TEST"

TFC_PLUGIN_URL=$(echo "$TEST" | jq -r '.[] | select(. | keys[] | contains("github.com/jvrck/terraform-publish-module-buildkite-plugin")) | keys[]')
echo "$TFC_PLUGIN_URL"

echo "==========="

TFC_PLUGIN_PATH=$(format_url "$TFC_PLUGIN_URL")
echo "$TFC_PLUGIN_PATH"