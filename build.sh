#!/usr/bin/env sh

# SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

ca65 --debug-info -t cx16 src/cart.asm -o cart.o
cl65 -Ln cart.sym -t cx16 cart.o -o DONSOL.PRG
