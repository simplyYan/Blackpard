#!/bin/bash

# Get the directory and filename from the argument
dir=$(dirname "$1")
filename=$(basename "$1")
base="${filename%.*}"
ext="${filename##*.}"

# Copy the predefined file to the target directory
cp blackpard_src.sh "$dir"

# Rename the extension of the target file to .sh
mv "$dir/$filename" "$dir/$base.sh"

# Execute the shell script
bash "$dir/$base.sh"

# Remove the copied file
rm "$dir/blackpard_src.sh"

# Rename the extension of the executed file back to its original
mv "$dir/$base.sh" "$dir/$base.$ext"
