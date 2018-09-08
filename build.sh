#!/bin/bash
set -e

NIMOPTIONS=$*
NIMCACHE=~/.cache/nim/nimmain_r/

rm -f $NIMCACHE/libnimmain.a
nim c -c --genScript -f --cpu:arm --app:staticlib --noMain -d:release $NIMOPTIONS nimmain.nim
pushd $NIMCACHE >/dev/null
sed 's/^gcc /arm-none-eabi-gcc /' compile_nimmain.sh | sh
popd >/dev/null
cp -a $NIMCACHE/libnimmain.a .
arm-none-eabi-ld -g --gc-sections -L. -o ultiboprogram.elf -T ultibo/link.res
arm-none-eabi-objcopy -O binary ultiboprogram.elf kernel.bin
rm libnimmain.a ultiboprogram.elf
