#!/bin/bash
set -e
 
nim c -c --genScript -f --cpu:arm --app:staticlib --os:standalone --gc:none --noMain -d:release nimmain.nim
pushd ~/.cache/nim/nimmain_r/ >/dev/null
sed 's/^gcc /arm-none-eabi-gcc /' compile_nimmain.sh | sh
popd >/dev/null
cp -a ~/.cache/nim/nimmain_r/libnimmain.a .
arm-none-eabi-ld -g --gc-sections -L. -o ultiboprogram.elf -T linker.ld
arm-none-eabi-objcopy -O binary ultiboprogram.elf kernel.bin
rm libnimmain.a ultiboprogram.elf
