#!/bin/sh

cat $ROOT/vscode/extensions.list | while read line
do
  code --install-extension $line
done
