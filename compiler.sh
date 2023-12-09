#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_shell_script>"
    exit 1
fi

# File to be copied
file_to_copy="blackpard_src.sh"

# Shell script to be executed
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

# Execute the shell script passed as an argument
"$shell_script"

# After executing the shell script, delete the copied file
rm "$destination_directory/$file_to_copy"

# Check if the deletion was successful
if [ $? -eq 0 ]; then
    echo "File '$file_to_copy' deleted from '$destination_directory'."
else
    echo "There was an error deleting the file '$file_to_copy' from '$destination_directory'."
fi
