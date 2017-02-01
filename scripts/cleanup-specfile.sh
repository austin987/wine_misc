#!/bin/sh
#
# Copyright 2017 Austin English <austinenglish!gmail.com>
# LGPL 2.1+
#
# Take a winedump generated .spec file, and reformats it for submission upstream
# Note: this does not preserve ordinals (rarely needed).

specfile="$1"

if [ -z "${specfile}" ] ; then
    echo "You must specify a specfile as an argument!"
    echo "e.g., $0 foo.spec"
    exit 1
fi

mv "${specfile}" "${specfile}.orig"
grep stub "${specfile}.orig" | sed 's/[^ ]* /@ /' > "${specfile}"
echo "${specfile} has been updated. Original is at ${specfile}.orig"
