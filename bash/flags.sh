#!/bin/bash

while test $# -gt 0; do
  case "$1" in
    -a)
      echo "test a"
      exit 1
      ;;
    -b)
      echo "test b"
      exit 1
      ;;
  esac
done

echo "nic"
