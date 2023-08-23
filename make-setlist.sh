#!/bin/bash

CHORDPRO=~/github/chordpro/chordpro/script/chordpro
perl $CHORDPRO --config=config.json -filelist setlist.txt -o setlists/setlist.pdf
