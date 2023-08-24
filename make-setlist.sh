#!/bin/bash

CHORDPRO=~/github/chordpro/chordpro/script/chordpro
SETLIST="23-10-15"
VERSION="1"
mkdir -p setlists/$SETLIST

perl $CHORDPRO --config=config.json -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST-v${VERSION}.pdf

perl $CHORDPRO --config=config.json songs/BlazeOn.chopro -o setlists/$SETLIST/BlazeOn.pdf
