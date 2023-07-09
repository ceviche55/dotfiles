#!/bin/sh

rm ~/dotfiles/.archivedDots
mv ~/dotfiles/cfg ~/dotfiles/.archivedDots

# Specify the directories
search_dir="~/dotfiles/.archivedDots"
target_dir="~/.configArchive"
copy_dir="~/dotfiles/cfg"

# Check if search directory exists
if [ ! -d "$search_dir" ]; then
  echo "Search directory does not exist."
  exit 1
fi

# Check if target directory exists
if [ ! -d "$target_dir" ]; then
  echo "Target directory does not exist."
  exit 1
fi

# Check if copy directory exists
if [ ! -d "$copy_dir" ]; then
  echo "Copy directory does not exist."
  exit 1
fi

# Get folder names in the search directory
folder_names=($(find "$search_dir" -maxdepth 1 -type d -printf "%f\n"))

# Check if any folders found
if [ ${#folder_names[@]} -eq 0 ]; then
  echo "No folders found in the search directory."
  exit 1
fi

# Loop through the folder names
for folder_name in "${folder_names[@]}"; do
  # Check if folder exists in the target directory
  if [ -d "$target_dir/$folder_name" ]; then
    echo "Folder '$folder_name' found in the target directory. Copying..."
    cp -r "$target_dir/$folder_name" "$copy_dir"
    echo "Folder '$folder_name' copied to the copy directory."
  else
    echo "Folder '$folder_name' not found in the target directory."
  fi
done

