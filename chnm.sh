#!/bin/sh

# This script is used to change the name for this tauri project
CURRENT_PROJECT_NAME="$(grep '"name"' package.json | head -n 1 | sed -E 's/.*"name": *"(.*)".*/\1/')"
NEW_PROJECT_NAME="$1"
PATH_PACKAGE_JSON="$(pwd)/package.json"
PATH_CARGO_TOML="$(pwd)/src-tauri/Cargo.toml"
PATH_TAURI_CONF="$(pwd)/src-tauri/tauri.conf.json"

if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_INPLACE="$HOMEBREW_PREFIX/bin/gsed -i"
else
  SED_INPLACE="sed -i"
fi

# Check if the new project name is provided
if [ -z "$NEW_PROJECT_NAME" ]; then
  echo "Please provide a new project name."
  exit 1
fi

# Check if the current project name is set
if [ -z "$CURRENT_PROJECT_NAME" ]; then
  echo "Current project name is not set. Please set it in the script."
  exit 1
fi

# Check if the current project name is the same as the new project name
if [ "$CURRENT_PROJECT_NAME" = "$NEW_PROJECT_NAME" ]; then
  echo "The new project name is the same as the current project name."
  exit 1
fi

# package.json
$SED_INPLACE -i "s/\"name\": \"$CURRENT_PROJECT_NAME\"/\"name\": \"$NEW_PROJECT_NAME\"/g" "$PATH_PACKAGE_JSON";``

# Cargo.toml
$SED_INPLACE -i "s/name = \"$CURRENT_PROJECT_NAME\"/name = \"$NEW_PROJECT_NAME\"/g" "$PATH_CARGO_TOML";

# tauri.conf.json
$SED_INPLACE -i "s/\"productName\": \"$CURRENT_PROJECT_NAME\"/\"productName\": \"$NEW_PROJECT_NAME\"/g" "$PATH_TAURI_CONF";
$SED_INPLACE -i "s/\"title\": \"$CURRENT_PROJECT_NAME\"/\"title\": \"$NEW_PROJECT_NAME\"/g" "$PATH_TAURI_CONF";
