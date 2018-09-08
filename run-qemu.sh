#!/bin/bash
set -e

./build.sh
qemu-system-arm -M versatilepb -display none -cpu cortex-a8 -m 64M -kernel kernel.bin -serial stdio |& grep  -v ^pulseaudio:
