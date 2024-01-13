#!/usr/bin/env bash

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Length
// @raycast.mode compact

// Optional parameters:
// @raycast.icon 🧮
// @raycast.argument1 { "type": "text", "placeholder": "query" }

// Documentation:
// @raycast.description Get length of given string.
// @raycast.author uncenter
// @raycast.authorURL https://github.com/uncenter


echo ${#1}
