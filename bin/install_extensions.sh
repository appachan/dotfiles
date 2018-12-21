#!/bin/sh

cat ../vscode/extensions.list | while read line
do
  code --install-extension $line
done
