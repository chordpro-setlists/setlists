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
cat > "$html_file_path" <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>File List</title>
  <!-- Include Bootstrap CSS from CDN -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
  <h1 class="mt-4">File List</h1>
  <ul class="list-group mt-4">
EOF

# Get the length of the directory path for stripping
dir_length=${#directory}

# Traverse the directory recursively and generate links for .pdf and .chopro files
find "$directory" -type f \( -name "*.pdf" -o -name "*.chopro" \) | sort | while read -r file; do
    filename=$(basename "$file")  # Extract the filename without path
    escaped_filename=$(echo "$filename" | sed 's/\//\\\//g')  # Escape special characters
    relative_path="${file:$dir_length}"  # Get the relative path by stripping the top-level directory
    # Remove the leading slash, if present
    relative_path=$(echo "$relative_path" | sed 's/^\/\{0,1\}//')

    # Check if the file starts with "setlist"
    if [[ $filename == setlist* ]]; then
        # Write a link for each "setlist" file using Bootstrap classes
        echo "  <li class=\"list-group-item\"><a href=\"$relative_path\">$escaped_filename</a></li>" >> "$html_file_path"
    fi
done

# Traverse again to list other files
find "$directory" -type f \( -name "*.pdf" -o -name "*.chopro" \) | sort | while read -r file; do
    filename=$(basename "$file")  # Extract the filename without path
    escaped_filename=$(echo "$filename" | sed 's/\//\\\//g')  # Escape special characters
    relative_path="${file:$dir_length}"  # Get the relative path by stripping the top-level directory
    # Remove the leading slash, if present
    relative_path=$(echo "$relative_path" | sed 's/^\/\{0,1\}//')

    # Check if the file doesn't start with "setlist"
    if [[ $filename != setlist* ]]; then
        # Write a link for each other file using Bootstrap classes
        echo "  <li class=\"list-group-item\"><a href=\"$relative_path\">$escaped_filename</a></li>" >> "$html_file_path"
    fi
done

# Close the HTML structure
cat >> "$html_file_path" <<EOF
  </ul>
</div>

<!-- Include Bootstrap JS and Popper.js from CDN (optional) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
EOF

echo "HTML file '$html_filename' generated as 'index.html' in '$directory'."
