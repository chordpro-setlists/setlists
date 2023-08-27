# ChordPro-SetLists

The goal of ChordPro-SetLists is to provide a simple way to produce setlist PDF files in multiple formats to satisfy the differing needs of band members during practice and performance.

## 1. Motivation

### How we did it before

In our band, setlist chart creation and management has been an overly complex and error-prone process: 

First, Philip creates a Google Doc "Setlist notes page". This page contains the list of proposed songs, in order, along with notes (who sings, what key, notes about the structure of the tune), a link to a reference performance of the tune, and a link to a "vanilla" PDF version of the tune.  This document is made available to the band.

Next, Philip creates a "personal" version of the song in chopro format, that he imports into the OnSong app for display during performance. Importantly, this version is lyrics-only, no chords, although it may include performance notes such as who solos when.

Finally, Kevin creates a setlist for distribution to other members of the band which includes the chords as well as performance notes. This PDF file typically goes through a series of versions as new performance notes are added after rehearsals.

Here's a screen image showing these various sources of setlist info:

![](README-old.png)

This approach yields significant problems:
* The "Setlist Notes", "OnSong", and "PDF" documents represent multiple, potentially inconsistent "sources of truth". They have been inconsistent on numerous occasions.
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

The following illustrates how a single ChordPro source file can be used to generate a view of the song with and without chords, as well as a summary page with key information.

![](README-new.png)

Band members can select any combination of these PDF files to use during practice and performance. 

The benefits of this approach include:
* All of these views are consistent: while some views contain more (or less) information than others, there is no inconsistent information.  
* ChordPro-SetLists can generate custom PDFs to suit the needs of different band members.
* ChordPro-SetLists provides more information: the cover sheet lists the songs and keys in order, the PDF files contain links to the reference version, and the presentation is designed for readability onstage.
* ChordPro-SetLists yields an easy to navigate archive of prior setlists, documenting what we played, when we played, and how we played.
* Finally, implementing this approach using Git provides an opportunity for collaboration not present in the prior approach.

## 2. Installation

To install and run the system, you must install [ChordPro](https://www.chordpro.org/chordpro/chordpro-installation/).

Note that Windows is not yet supported.

Your installation is OK when you can invoke the chordpro command successfully:

```shell
% chordpro -V
This is ChordPro core 6.020 
```

## 3. Create a setlist

### 3.1 Create the setlist songlist file

The first step is creating a .txt file containing a list of songs. For example, the [tt-2023-08-9.txt](https://github.com/chordpro-setlists/setlists/blob/main/tt-2023-08-19.txt) songlist file looks like this:

```shell
songs/Bug.chopro
songs/BoogieOnReggaeWoman.chopro
songs/EverythingsRight.chopro
songs/Dirt.chopro
songs/LovingCup.chopro
```

By convention, the "songs/" directory contains a repository of the entire repertoire. The songlist file enables you to pick the songs and the order in which they will be played for a particular performance.

### 3.2 Create the setlist json file

Next, create a file with the same name and a .json suffix. This file is used to specify the title for the table of contents page. For example, the [tt-2023-08-9.json](https://github.com/chordpro-setlists/setlists/blob/main/tt-2023-08-19.json) file looks like this:

```shell
{
  "contents": [
    {
      "fields": [
        "songindex"
      ],
      "label": "Sunshine Family Farm Fundraiser (8/19/2023)",
      "line": "%{songindex} <span>   </span> %{title}",
      "pageno": "%{key}",
      "fold": false,
      "omit": false
    }
  ]
}
```

The only line you need to change is the one with the "label" field.

In future, this file will not be needed when ChordPro supports meta variables in this json file section.

### 3.3 Update the index.html file

Finally, you want to update the setlists/index.html file to provide public URLs to the PDF files. This enables band members easy access. For example, the [index.html](https://github.com/chordpro-setlists/setlists/blob/main/setlists/index.html) file looks like this:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Setlists</title>
    <link rel="stylesheet" href="./style.css">
    <link rel="icon" href="./favicon.ico" type="image/x-icon">
  </head>
  <body>
    <main>
        <h1>Setlists</h1>

        <h2>Sunshine Family Farm Fundraiser (8.19/23)</h2>
        <p>Hardly Strictly Jerry</p>
        <p>
          <ol>
          <li><a href="hsj-2023-08-19/setlist-hsj-2023-08-19-v1.pdf">Setlist</a></li>
          <li><a href="hsj-2023-08-19/setlist-hsj-2023-08-19-v1-lyrics.pdf">Setlist (no chords)</a></li>
          </ol>
        </p>
    </main>
  </body>
</html>

```

In future, this file will be auto-generated by a script and no manual editing will be required.

### 3.4 Update make-setlist.sh

The next step is to edit make-setlist.sh to generate the PDF files for your new setlist. For example,  [make-setlist.sh](https://github.com/chordpro-setlists/setlists/blob/main/make-setlist.sh) currently looks like:

```html
#!/bin/bash

SETLIST="hsj-2023-08-19"
VERSION="1"
mkdir -p setlists/$SETLIST
mkdir -p setlists/$SETLIST/songs

## Create the setlists (with and without lyrics)
echo "Generating setlists..."
chordpro --config=config.json --config=$SETLIST.json -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST-v${VERSION}.pdf

chordpro -l --config=config.json --config=$SETLIST.json -filelist $SETLIST.txt -o setlists/$SETLIST/setlist-$SETLIST-v${VERSION}-lyrics.pdf

## Create individual songs (with and without lyrics)
echo "Generating individual songs..."
while IFS= read -r filename; do

  chordpro --meta=user=$SETLIST --config=config.json $filename -o setlists/$SETLIST/"${filename%.chopro}.pdf"

  chordpro --meta=user=$SETLIST -l --config=config.json $filename -o setlists/$SETLIST/"${filename%.chopro}-lyrics.pdf"

done < "$SETLIST.txt"
```

In general, all you should need to do is edit the third line defining SETLIST.

### 3.5 Run make-setlist.sh

Now that everything is configured, you should be able to generate your new setlist by invoking `./make-setlist.sh`:

```sh
% ./make-setlist.sh 
Generating setlists...
Generating individual songs...
```

This will create (or overwrite) a subdirectory in the setlists/ directory that contains your new setlist. For example:

```
setlists/
         hsj-2023-08-19/
                        setlist-hsj-2023-08-19-v1.pdf
                        setlist-hsj-2023-08-19-v1-lyrics.pdf
                        songs/
                              Althea.pdf
                              :
```

### 3.6 Publish

Once the setlist looks the way you want it, you can commit your changes to GitHub. This will trigger a GitHub action that installs ChordPro and runs the `./make-setlist.sh` script, then publishes the `setlists/` directory.  If you have edited the index.html file correctly, then you can go to <https://chordpro-setlists.github.io/setlists/> to see your published setlist.
