#!/bin/bash

if ! pgrep -x "redshift" > /dev/null ; then
  redshift &
else
  pkill "redshift"
fi
