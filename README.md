# setlists

# Requirements

Old approach:
* Philip creates "Setlist notes page" (song order, key, links).
* Philip creates personal OnSong files.
* Kevin creates multiple versions of PDF of setlist with performance notes.

Problems with old approach
* Multiple, potentially inconsistent "sources of truth" (PJ vs. KH versions).
* KH version not appropriate for Philip (and vice versa)
* Some information "lost" (setlist notes page performance notes vs. PDF)

Goals of new approach
* Single source of truth
  * One file used to generate KH and PJ appropriate versions.
* Comprehensive 
  * Song file contains all of PJ's setlist notes page.
* New features
  * Easily accessible historical record of songs/setlists/etc.
  * PDF setlist contains key signature list on TOC, tempo information.
  * Multiple editors (both PJ and KH can collaborate on file) 


## To Do
* Implement a GitHub action to run a gh-pages for the setlists/ directory.
* Maybe add an index.md with links to make it easier to retrieve.
