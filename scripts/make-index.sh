#!/bin/bash

directory="setlists"
index_file="$directory/index.html"

if [ ! -d "$directory" ]; then
    echo "Error: The specified directory does not exist."
    exit 1
fi


html_filename="index.html"
html_file_path="$directory/$html_filename"  # Path to the HTML file within the specified directory

# Create the HTML file and write the initial HTML structure
cat > "$html_file_path" <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>Setlists</title>
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

for subdirectory in "$directory"/*/; do
    if [ -d "$subdirectory" ]; then
        subdirectory_name=$(basename "$subdirectory")
        echo "    <li class=\"list-group-item\"><a href=\"$subdirectory_name/\">$subdirectory_name/</a></li>" >> "$index_file"
    fi
done

echo "  </ul>" >> "$html_file_path"

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

## Now produce the subdirectory index files.
for subdirectory in "$directory"/*/; do
    if [ -d "$subdirectory" ]; then
        subdirectory_name=$(basename "$subdirectory")
        ./make-index-interior.sh "$subdirectory"
    fi
done
