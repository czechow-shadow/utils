#!/bin/bash

set -eu -o pipefail

DEST_DIR=~/bin

FILES=(mk-cabal-skel mk-nix-skel)
FORCE=

if [ $# -gt 1 ]; then
  usage;
  exit 1;
fi

if [ $# = 1 ]; then
  DEST_DIR="$1";
fi


for i in ${FILES[@]}; do
  f="$DEST_DIR/$i";
  fh=`pwd`/$i;

  if [ -e "$f" ]; then
  	echo "$f already exists";
	if [ -n "$FORCE" ]; then
  	  echo "Removing $f";
	  rm "$f";
	else
  	  echo "Aborted";
	  exit 2;
	fi
  fi

  ( cd $DEST_DIR && ln -s "$fh" "$i" )
done

echo "Installed ${FILES[@]} in $DEST_DIR";
