#!/usr/bin/env sh

ca65 --debug-info -t cx16 src/cart.asm -o cart.o
cl65 -t cx16 cart.o -o cart.prg
