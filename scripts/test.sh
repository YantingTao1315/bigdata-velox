#!/bin/bash
make format-check
if ! make format-check; then
  scripts/check.py format developer --fix
  echo -e "\n==== Apply using:"
  echo "patch -p1 \<<EOF"
  git --no-pager diff
  echo "EOF"
  false
fi

scripts/check.py header developer
if $?; then
  scripts/check.py header developer --fix
  echo -e "\n==== Apply using:"
  echo "patch -p1 \<<EOF"
  git --no-pager diff
  echo "EOF"
  false
fi