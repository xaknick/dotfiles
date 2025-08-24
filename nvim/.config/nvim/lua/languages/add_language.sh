#!/bin/bash

# Quick script to add a new language configuration
# Usage: ./add_language.sh <language_name> [lsp|dap|tools]

if [ $# -lt 1 ]; then
    echo "Usage: $0 <language_name> [lsp|dap|tools...]"
    echo "Examples:"
    echo "  $0 python lsp tools    # Creates python/lsp.lua and python/tools.lua"
    echo "  $0 cpp lsp dap tools   # Creates all three files"
    echo "  $0 zig                 # Creates directory only"
    exit 1
fi

LANGUAGE=$1
LANG_DIR="$(dirname "$0")/$LANGUAGE"
TEMPLATES_DIR="$(dirname "$0")/templates"

# Create language directory
mkdir -p "$LANG_DIR"
echo "Created directory: $LANG_DIR"

# Copy requested templates
shift
for template in "$@"; do
    if [ -f "$TEMPLATES_DIR/$template.lua" ]; then
        cp "$TEMPLATES_DIR/$template.lua" "$LANG_DIR/$template.lua"
        echo "Created: $LANG_DIR/$template.lua (from template)"
    else
        echo "Warning: Template $template.lua not found"
    fi
done

echo ""
echo "Next steps:"
echo "1. Edit lua/languages/init.lua and add '$LANGUAGE' to the languages array"
echo "2. Customize the created files as needed"
echo "3. See README.md for examples and best practices"