#!/bin/bash

remove_create_date() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <input_pdf>"
        exit 1
    fi

    input_pdf="$1"

    # Check if the input file exists
    if [ ! -f "$input_pdf" ]; then
        echo "Input PDF file not found: $input_pdf"
        exit 1
    fi

    # Remove the create date metadata using exiftool
    exiftool -overwrite_original -createdate= "$input_pdf"
    # exiftool -createdate "$input_pdf"

    echo "Created metadata removed from $input_pdf"
}

# Call the function with the provided PDF file as an argument
remove_create_date "$1"
