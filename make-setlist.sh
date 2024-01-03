#!/bin/bash

#SETLIST="phish"
SETLIST="jam-2024-01-10"
# SETLIST="tt-december"
# SETLIST="jam-2023-10-18"
# SETLIST="jam-2023-11-08"
# SETLIST="jam-2023-12-06"
VERSION="" # Could replace with "-V1" if you want versioning.
mkdir -p setlists/$SETLIST
mkdir -p setlists/$SETLIST/songs

## Create the setlists (with and without lyrics)
echo "Generating setlist for $SETLIST..."
chordpro --config=scripts/config.json --config=scripts/contents.json -filelist setlist-definitions/$SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST${VERSION}.pdf

chordpro -l --config=scripts/config.json --config=scripts/contents.json -filelist setlist-definitions/$SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST${VERSION}.nochords.pdf

## Create individual songs (with and without lyrics)
echo "Generating individual songs..."
while IFS= read -r filename; do
  echo "  $filename"

  chordpro --meta=user=$SETLIST --config=scripts/config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.pdf"

  chordpro --meta=user=$SETLIST -l --config=scripts/config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.nochords.pdf"

  cp $filename setlists/$SETLIST/songs/

done < "setlist-definitions/$SETLIST.txt"
