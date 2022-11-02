#!/bin/sh

pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY /opt/debiantools/mountiso.sh "$1"

