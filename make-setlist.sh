#!/bin/bash

SETLIST="tt-2023-08-19"
VERSION="1"
mkdir -p setlists/$SETLIST
mkdir -p setlists/$SETLIST/songs

## Create the setlists (with and without lyrics)
echo "Generating setlists..."
chordpro --config=config.json --config=$SETLIST.json -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST-v${VERSION}.pdf

chordpro -l --config=config.json --config=$SETLIST.json -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST-v${VERSION}.nochords.pdf

## Create individual songs (with and without lyrics)
echo "Generating individual songs..."
while IFS= read -r filename; do

  chordpro --meta=user=$SETLIST --config=config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.pdf"

  chordpro --meta=user=$SETLIST -l --config=config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.nochords.pdf"

done < "$SETLIST.txt"
