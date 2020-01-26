#!/bin/bash
set -e

if [ "$1" = 'vddos' ]; then
  vddos start
  trap : TERM INT; sleep infinity & wait
  vddos stop
fi

exec "$@"
