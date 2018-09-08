#!/bin/bash
set -e

NIMCACHE=~/.cache/nim/nimmain_r/

nim c -c --genScript -f --cpu:arm --app:staticlib -d:release nimmain.nim
pushd $NIMCACHE >/dev/null
sed 's/^gcc /arm-none-eabi-gcc /' compile_nimmain.sh | sh
popd >/dev/null
cp -a $NIMCACHE/libnimmain.a .
arm-none-eabi-ld -g --gc-sections -L. -o ultiboprogram.elf -T linker.ld
arm-none-eabi-objcopy -O binary ultiboprogram.elf kernel.bin
rm libnimmain.a ultiboprogram.elf
