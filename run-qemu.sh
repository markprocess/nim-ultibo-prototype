#!/bin/bash
set -e

NIMOPTIONS=$*

./build.sh $NIMOPTIONS
qemu-system-arm -M versatilepb -display none -cpu cortex-a8 -m 64M -kernel kernel.bin -serial stdio |& grep  -v ^pulseaudio:
