#!/bin/sh

cat ./extensions.list | while read line
do
  code --install-extension $line
done
