#!/bin/sh

cat ../.config/vscode/extensions.list | while read line
do
  code --install-extension $line
done
