#!/bin/bash

# Check if a directory parameter is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory="$1"
html_filename="index.html"
html_file_path="$directory/$html_filename"  # Path to the HTML file within the specified directory

# Create the HTML file and write the initial HTML structure
echo "<html>
<head>
<title>ChordPro-SetList</title>
</head>
<body>
<h1>ChordPro-SetList</h1>
<ul>" > "$html_file_path"

# Get the length of the directory path for stripping
dir_length=${#directory}

# Traverse the directory recursively and generate links for .pdf and .chopro files
find "$directory" -type f \( -name "*.pdf" -o -name "*.chopro" \) | sort | while read -r file; do
    filename=$(basename "$file")  # Extract the filename without path
    escaped_filename=$(echo "$filename" | sed 's/\//\\\//g')  # Escape special characters
    relative_path="${file:$dir_length}"  # Get the relative path by stripping the top-level directory
    # Remove the leading slash, if present
    relative_path=$(echo "$relative_path" | sed 's/^\/\{0,1\}//')
    # Write a link for each file
    echo "<li><a href=\"$relative_path\">$escaped_filename</a></li>" >> "$html_file_path"
done

# Close the HTML structure
echo "</ul>
</body>
</html>" >> "$html_file_path"

echo "HTML file '$html_filename' generated in '$directory'."
