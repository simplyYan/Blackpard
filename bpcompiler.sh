#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_file>"
    exit 1
fi

# File to be copied
file_to_copy="blackpard_src.sh"

# Shell script file to be renamed and executed
shell_script="$1"

# Get the directory of the passed shell script argument
destination_directory=$(dirname "$shell_script")

# Check if the destination directory exists
if [ ! -d "$destination_directory" ]; then
    echo "Destination directory not found: $destination_directory"
    exit 1
fi

# Copy the file to the destination directory
cp "$file_to_copy" "$destination_directory"

# Check if the copy was successful
if [ $? -ne 0 ]; then
    echo "There was an error copying the file '$file_to_copy' to '$destination_directory'."
    exit 1
fi

# Get the filename without extension
filename=$(basename "$shell_script" ".${shell_script##*.}")

# Rename the file to have ".sh" extension
mv "$shell_script" "$destination_directory/$filename.sh"

# Execute the renamed shell file
"$destination_directory/$filename.sh"

# After executing the shell file, delete the copied file and rename back to original extension
rm "$destination_directory/$file_to_copy"
mv "$destination_directory/$filename.sh" "$destination_directory/$filename.${file_to_copy##*.}"

# Check if operations were successful
if [ $? -eq 0 ]; then
    echo "File '$file_to_copy' deleted from '$destination_directory'."
    echo "File '$filename.sh' renamed to '$filename.${file_to_copy##*.}'"
else
    echo "There was an error performing operations in '$destination_directory'."
fi
