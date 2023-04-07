#!/usr/bin/env sh

image2binary -w 32 -h 32 -a mb image-tile-map -b 2 -p 1 -a tb sprite.png

mv PALETTE.BIN palette.bin
mv SPRITE.BIN sprite.bin
