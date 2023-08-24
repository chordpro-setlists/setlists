#!/bin/bash

CHORDPRO=~/github/chordpro/chordpro/script/chordpro
SETLIST="23-10-15"
VERSION="1"
mkdir -p setlists/$SETLIST

perl $CHORDPRO --config=config.json --meta setlist=$SETLIST -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST-v${VERSION}.pdf

perl $CHORDPRO -l --config=config.json --meta setlist=$SETLIST -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST-v${VERSION}-lyrics.pdf

perl $CHORDPRO --meta=user=$SETLIST --config=config.json songs/BlazeOn.chopro -o setlists/$SETLIST/BlazeOn.pdf

perl $CHORDPRO --meta=user=$SETLIST -l --config=config.json songs/BlazeOn.chopro -o setlists/$SETLIST/BlazeOn-lyrics.pdf
