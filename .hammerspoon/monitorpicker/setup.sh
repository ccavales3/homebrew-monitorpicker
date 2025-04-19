#!/bin/bash

set -e

SOURCE_DIR="$(brew --prefix)/opt/monitorpicker/libexec"
TARGET_DIR="$HOME/.hammerspoon/monitorpicker"

echo "📦 Installing MonitorPicker config files..."
mkdir -p "$TARGET_DIR"

cp "$SOURCE_DIR/init.lua" "$TARGET_DIR/init.lua"
cp "$SOURCE_DIR/monitor_picker.lua" "$TARGET_DIR/monitor_picker.lua"

echo "✅ Files installed to: $TARGET_DIR"

# Suggest init.lua update
INIT_LUA="$HOME/.hammerspoon/init.lua"
if grep -q 'require("monitorpicker")' "$INIT_LUA" 2>/dev/null; then
  echo "🧠 'monitorpicker' is already required in your ~/.hammerspoon/init.lua"
else
  echo
  echo "📌 To complete setup, add this line to ~/.hammerspoon/init.lua:"
  echo 'require("monitorpicker")'
  echo
fi

echo "🚀 Reload Hammerspoon and enjoy!"
