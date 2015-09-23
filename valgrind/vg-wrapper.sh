#!/bin/sh
#
# short script to source for running tests under valgrind
# Usage:
# terminal 1: ./wine notepad # run wineserver, without valgrind
# terminal 2: . vg-wrapper.sh && cd $WINESRC/dlls/advapi32/tests/ && make cred.ok
#
# Copyright: 2014 Austin English <austinenglish@gmail.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

export WINESRC="$HOME/wine-valgrind"
export WINE="$WINESRC/wine"
export WINESERVER="$WINESRC/server/wineserver"

export WINETEST_WRAPPER=/opt/valgrind/bin/valgrind
#export WINETEST_WRAPPER=valgrind

# suppress known bugs
#export VALGRIND_OPTS="-q --trace-children=yes --track-origins=yes --gen-suppressions=all --suppressions=$WINESRC/tools/valgrind/valgrind-suppressions-ignore --suppressions=$WINESRC/tools/valgrind/valgrind-suppressions-external --suppressions=$WINESRC/tools/valgrind/valgrind-suppressions-known-bugs --suppressions=$WINESRC/tools/valgrind/valgrind-suppressions-gecko --leak-check=full --num-callers=20  --workaround-gcc296-bugs=yes --vex-iropt-register-updates=allregs-at-mem-access"

# don't suppress known bugs
export VALGRIND_OPTS="-q --trace-children=yes --track-origins=yes --gen-suppressions=all --suppressions=$WINESRC/tools/valgrind/valgrind-suppressions-ignore --suppressions=$WINESRC/tools/valgrind/valgrind-suppressions-external --suppressions=$WINESRC/tools/valgrind/valgrind-suppressions-gecko --leak-check=full --num-callers=20  --workaround-gcc296-bugs=yes --vex-iropt-register-updates=allregs-at-mem-access"

export WINETEST_TIMEOUT=600
export WINE_HEAP_TAIL_REDZONE=32
export OANOCACHE=1
