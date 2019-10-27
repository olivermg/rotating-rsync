#!/usr/bin/env bash

ORIGINALDIR=$1
if [ -z "$ORIGINALDIR" ]; then
	echo "USAGE: $0 <originaldir> <bakname> <1 2 ..>" >&2
	echo "       e.g. $0 $HOME/importantdata weekly 1 2 3 4 5" >&2
	exit 1
fi
if [ ! -d $ORIGINALDIR ]; then
	echo "ERROR: $ORIGINALDIR does not exist" >&2
	exit 2
fi
shift
BASEDIR=$(dirname $ORIGINALDIR)

BAKNAME=$1
if [ -z "$BAKNAME" ]; then
	BAKNAME=daily
fi
shift

COPIES=$@

for N in $(echo "$COPIES"|rev); do
	SRCN=$(( $N - 1 ))
	if [ $SRCN -gt 0 ]; then
		SRCDIR="${BASEDIR}/${BAKNAME}${SRCN}"
		DESTDIR="${BASEDIR}/${BAKNAME}${N}"
	else
		SRCDIR="${ORIGINALDIR}"
		DESTDIR="${BASEDIR}/${BAKNAME}${N}"
	fi

	if [ ! -d $SRCDIR ]; then
		echo "ERROR: source directory $SRCDIR does not exist - skipping" >&2
		continue;
	fi
	if [ ! -d $DESTDIR ]; then
		echo "NOTE: creating destination directory $DESTDIR" >&2
		mkdir -p $DESTDIR
	fi

	#CMD="rsync -avxHAXE --delete ${SRCDIR}/ ${DESTDIR}/"
	CMD="rsync -avx --delete ${SRCDIR}/ ${DESTDIR}/"
	$CMD
done

sync

