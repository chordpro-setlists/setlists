#!/bin/bash


SETLIST="2026-02-14-hsj"
VERSIONNUM="8"
VERSIONSUFFIX="-V$VERSIONNUM"
mkdir -p setlists/$SETLIST
mkdir -p setlists/$SETLIST/songs

## Set up the table of contents
cp -f scripts/contents-template.json scripts/contents.json
sed -i -e "s/@TITLE@/$SETLIST/g" scripts/contents.json
if  ! [[ -z "${VERSIONNUM}" ]]; then
  sed -i -e "s/@VERSION@/(v $VERSIONNUM)/g" scripts/contents.json
fi
# Because macOS sed is different and will leave this file behind.
rm -f scripts/contents.json-e

## Set up the config file.
cp -f scripts/config-template.json scripts/config.json
sed -i -e "s/@TITLE@/$SETLIST/g" scripts/config.json
rm -f scripts/config.json-e


## Create the setlists (with and without lyrics)
echo "Generating setlist for $SETLIST..."
chordpro --config=scripts/config.json --config=scripts/contents.json -filelist setlist-definitions/$SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST${VERSIONSUFFIX}.pdf

chordpro -l --config=scripts/config.json --config=scripts/contents.json -filelist setlist-definitions/$SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST${VERSIONSUFFIX}.nochords.pdf

## Create individual songs (with and without lyrics)
#echo "Generating individual songs..."
#while IFS= read -r filename; do
#  echo "  $filename"
#
#  chordpro --meta=user=$SETLIST --config=scripts/config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.pdf"
#
#  chordpro --meta=user=$SETLIST -l --config=scripts/config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.nochords.pdf"
#
#  cp $filename setlists/$SETLIST/songs/
#
#done < "setlist-definitions/$SETLIST.txt"
