#!/bin/sh
# Copyright 2016 - Austin English
# License: LGPL 2.1+
#
# Simple script to count stubs in Wine, and summarize them by file / across tree
# As of 2016/12/29 - wine-2.0-rc3-4-gc0b30432ea:
# There are a total of 27761 stubs across 372 specfiles (with stubs) in the tree)

# Future ideas: find a way to constructively search github.com for stubs, to find real code
# Need to exlude wine repos and .def files though

#set -x

WINESRC="${WINESRC:-$HOME/wine-git}"

tmpdir="$(mktemp -d)"
countfile="${tmpdir}/counts"
grep_stub="@ stub"
verbose=0

# only option is verbose:
if [ "$1" = "-v" ] ; then verbose=1 ; fi

cd "$WINESRC/dlls" || exit 1

for specfile in */*.spec ; do
    count=$(grep -c "${grep_stub}" "${specfile}")

    # shellcheck disable=SC2086
    if [ ${count} = 0 ] && [ ${verbose} = 0 ] ; then
        :
    elif [ ${count} = 0 ] && [ ${verbose} = 1 ] ; then
        echo "No stubs in ${specfile}"
    elif [ ${verbose} = 0 ] ; then
        echo "$specfile: ${count}"
    elif [ ${verbose} = 1 ] ; then
        echo "$specfile has ${count} stubs:"
        grep "${grep_stub}" "${specfile}"
    else
        echo "Unknown error"
    fi

    # summarize totals for end:
    if [ "${count}" != 0 ] ; then
        echo "${count}" >> "${countfile}"
    fi
done

# This count excludes files with no stubs
total_specfiles="$(wc -l < "${countfile}")"
total_stubs="$(awk '{s+=$1} END {print s}' "${countfile}")"

echo "There are a total of ${total_stubs} stubs across ${total_specfiles} specfiles (with stubs) in the tree)"

rm -rf "${tmpdir}"
