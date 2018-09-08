#!/bin/bash
set -e

LPR=ultiboprogram
PROC=QEMUVPB
ARCH=ARMV7a

ULTIBO=$HOME/ultibo/core
ULTIBOBIN=$ULTIBO/fpc/bin
export PATH=$ULTIBOBIN:$PATH
set +e
which fpc > /dev/null
if [[ $? == 0 ]]
then
    echo ultibo must be installed
    exit 1
fi
set -e

rm -f *.o *.ppu link.res link.sh ppas.sh
fpc -Cn -dBUILD_$CPROC -B -O2 -Tultibo -Parm -Cp$ARCH -Wp$PROC -Fi$ULTIBO/source/rtl/ultibo/extras -Fi$ULTIBO/source/rtl/ultibo/core @$ULTIBOBIN/$PROC.CFG $LPR.lpr
sed -i '/^SEARCH_DIR/d' link.res
sed -i 's!^/home/pi/!../lib/!' link.res
mv link.res ../linker.ld
