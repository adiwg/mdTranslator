#!/bin/bash

# Verify that the gemspec file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <gemspec-file>"
  exit 1
fi

gem push "$1"