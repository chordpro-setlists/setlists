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

EOF

# Get the length of the directory path for stripping
dir_length=${#directory}

echo "<div class=\"container\">
        <h1 class=\"mt-4\">Set Lists</h1>
        <ul class=\"list-group mt-4\">" >> "$html_file_path"

# Traverse the directory recursively and generate links for .nochord.pdf files
find "$directory" -type f -name "*.nochords.pdf" | sort | while read -r file; do
    filename=$(basename "$file")  # Extract the filename without path
    escaped_filename=$(echo "$filename" | sed 's/\//\\\//g')  # Escape special characters
    relative_path="${file:$dir_length}"  # Get the relative path by stripping the top-level directory
    # Remove the leading slash, if present
    relative_path=$(echo "$relative_path" | sed 's/^\/\{0,1\}//')
    relative_path_no_ext="${relative_path%.nochords.pdf}"
    filepath_chords="${relative_path_no_ext}.pdf"
    filepath_nochords="${relative_path_no_ext}.nochords.pdf"
    filename_no_ext="${filename%.nochords.pdf}"

    # Write a link for each setlist file using Bootstrap classes
    if [[ $filename = setlist* ]]; then
      echo "  <li class=\"list-group-item\">$filename_no_ext (<a href=\"$filepath_chords\">chords</a>, <a href=\"$filepath_nochords\">no chords</a>)</li>" >> "$html_file_path"
    fi
done

echo "  </ul>
        <h1 class=\"mt-4\">Songs</h1>
        <ul class=\"list-group mt-4\">" >> "$html_file_path"

find "$directory" -type f -name "*.nochords.pdf" | sort | while read -r file; do
    filename=$(basename "$file")  # Extract the filename without path
    escaped_filename=$(echo "$filename" | sed 's/\//\\\//g')  # Escape special characters
    relative_path="${file:$dir_length}"  # Get the relative path by stripping the top-level directory
    # Remove the leading slash, if present
    relative_path=$(echo "$relative_path" | sed 's/^\/\{0,1\}//')
    relative_path_no_ext="${relative_path%.nochords.pdf}"
    filepath_chords="${relative_path_no_ext}.pdf"
    filepath_nochords="${relative_path_no_ext}.nochords.pdf"
    filepath_chopro="${relative_path_no_ext}.chopro"
    filename_no_ext="${filename%.nochords.pdf}"

    # Write a link for each non-setlist file using Bootstrap classes
    if [[ $filename != setlist* ]]; then
      echo "  <li class=\"list-group-item\">$filename_no_ext (<a href=\"$filepath_chords\">chords</a>, <a href=\"$filepath_nochords\">no chords</a>)</li>, <a href=\"$filepath_chopro\">chopro</a>)</li>" >> "$html_file_path"
    fi
done

echo " </ul>" >> "$html_file_path"

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
