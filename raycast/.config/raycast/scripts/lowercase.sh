#!/usr/bin/env bash

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Lowercase
// @raycast.mode compact

// Optional parameters:
// @raycast.icon 🔡
// @raycast.argument1 { "type": "text", "placeholder": "query" }

// Documentation:
// @raycast.description Make text lowercase.
// @raycast.author uncenter
// @raycast.authorURL https://github.com/uncenter


x=$(echo "$1" | tr "[:upper:]" "[:lower:]")
echo $x | pbcopy && echo $x
