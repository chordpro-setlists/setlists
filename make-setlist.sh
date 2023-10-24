#!/bin/bash

#SETLIST="jam-2023-10-18"
SETLIST="jam-2023-11-08"
VERSION="" # Could replace with "-V1" if you want versioning.
mkdir -p setlists/$SETLIST
mkdir -p setlists/$SETLIST/songs

## Create the setlists (with and without lyrics)
echo "Generating setlist for $SETLIST..."
chordpro --config=config.json --config=$SETLIST.json -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST${VERSION}.pdf

chordpro -l --config=config.json --config=$SETLIST.json -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST${VERSION}.nochords.pdf

## Create individual songs (with and without lyrics)
echo "Generating individual songs..."
while IFS= read -r filename; do
  echo "  $filename"

  chordpro --meta=user=$SETLIST --config=config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.pdf"

  chordpro --meta=user=$SETLIST -l --config=config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.nochords.pdf"

  cp $filename setlists/$SETLIST/songs/

done < "$SETLIST.txt"
