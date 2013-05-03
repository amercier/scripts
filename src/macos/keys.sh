#!/bin/bash

[ ! -d ~/Library/KeyBindings ] && sudo mkdir ~/Library/KeyBindings \
&& echo "Created /etc/profile directory" \
|| echo "~/Library/KeyBindings already exists, skipping"

echo '{
/* Remap Home / End keys to be correct */
"\UF729" = "moveToBeginningOfLine:"; /* Home */
"\UF72B" = "moveToEndOfLine:"; /* End */
"$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
"$\UF72B" = "moveToEndOfLineAndModifySelection:"; /* Shift + End */
"^\UF729" = "moveToBeginningOfDocument:"; /* Ctrl + Home */
"^\UF72B" = "moveToEndOfDocument:"; /* Ctrl + End */
"$^\UF729" = "moveToBeginningOfDocumentAndModifySelection:"; /* Shift + Ctrl + Home */
"$^\UF72B" = "moveToEndOfDocumentAndModifySelection:"; /* Shift + Ctrl + End */
}' > ~/Library/KeyBindings/DefaultKeyBinding.dict \
&& echo "~/Library/KeyBindings/DefaultKeyBinding.dict written successfully. You need to restart MacOS for the changes to take effect."
