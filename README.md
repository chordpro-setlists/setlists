# ChordPro-SetLists

The goal of chordpro-setlists is to provide a simple way to produce setlist PDF files in multiple formats (for example, with and without chords). 

## 1. Motivation

### How we did it before

In our band, setlist chart creation has been a complex and error-prone process: 

First, Philip creates a Google Doc "Setlist notes page". This page contains the list of proposed songs, in order, along with notes (who sings, what key, notes about the structure of the tune), a link to a reference performance of the tune, and a link to a "vanilla" PDF version of the tune.  This document is made available to the band.

Next, Philip creates a "personal" version of the song in chopro format, that he imports into the OnSong app for display during performance. Importantly, this version is lyrics-only, no chords, although it may include performance notes such as who solos when.

Finally, Kevin creates a setlist for distribution to other members of the band which includes the chords as well as performance notes. This PDF file typically goes through a series of versions as new performance notes are added after rehearsals.

Here's a screen image showing these various sources of setlist info:

![](README-old.png)

This approach yields significant problems:
* Philip's Google Doc and ChoPro files and Kevin's PDF files represent multiple, potentially inconsistent "sources of truth". They have been inconsistent on numerous occasions.
* We can't get rid of multiple versions: Philip does not want a cluttered page while others want the chord diagrams. 
* Some information gets "lost" altogether (for example, neither version results in a convenient listing of songs and key signature, which is originally present in Philip's Google Doc).

### How chordpro-setlists helps

chordpro-setlists is designed to address these problems. 

In chordpro-setlists, there is a songs/ directory that contains ChordPro versions for each song that can appear in the setlist currently under development.  (The songs/ directory can and typically will contain many other songs as well.)

Each ChordPro song file contains lyrics, chords, key, tempo, performance notes, and a link to a reference version. It is a complete reference guide to the important aspects of the tune for performance.

To produce a setlist, you create two files: a text file containing a list of songs, in order, as well as a json file that contains the string you wish to use for the table of contents. 

Then you edit the make-setlist.sh file to refer to these two files, and run it. 

Running the make-setlist.sh file creates (or overwrites) a directory and adds to it:
  * Two PDF versions of the setlist, one with and one without the chord information.
  * A subdirectory called "songs/" with two PDF versions for each song, one with and one without chord information.

Band members can select any combination of these PDF files to download. All of these files are consistent: while some files contain more information than others, there is no inconsistent information.  Have a "single source of truth" produce all PDF files is the first benefit of this approach.

The second benefit is that Kevin and Philip (and other band members) can each have their own preferred format. 

Third, there is more information made available this way: the cover sheet lists the songs and keys in order, the PDF files contain links to the reference version, and the presentation is designed for readability onstage. 

Fourth, while the setlist "archive" to date has been haphazard (to say the least), this approach yields an easy to navigate archive of what we played, when we played it, and how we played it. 

Finally, this approach provides an opportunity for collaboration not present in the prior approach.

## 2. Local installation

### Install ChordPro

### Create a setlist

### Refine and iterate

### Publish

## 3. Cloud-based installation
