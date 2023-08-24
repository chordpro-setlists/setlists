# setlists

## To Do: Phase I
* Determine correct use of command line --meta argument.
* Decide how to format "performance notes"
  * {start_of_notes}? (this allows attaching formatting, maybe)
  * {start_of_kevin} (kevin-specific formatting?)
  * Use command-line meta to include/exclude? 
* Provide complete formatting for BlazeOn
  * chords
  * solo sections
  * performance notes
  * meta data
* Generate setlists/ directory with subdirectories for setlists.
  * Include PDFs for individual files, lyrics/no-lyrics, include/exclude meta-data
  * Generate combined PDF with the entire setlist. 
* Implement a GitHub action to run a gh-pages for the setlists/ directory.
* Maybe add an index.md with links to make it easier to retrieve.

## Done
* set "even-odd-pages" and pagealign-songs to 0 to prevent empty page
* Install ChordPro (finally, from the github repo)
* Create chordpro command
  * alias chordpro="perl ~/github/chordpro/chordpro/script/chordpro"
