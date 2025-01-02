#!/usr/bin/bash
directory_path=$1
# /home/ahmedshawky/Documents/github-embeddedlinuxdiploma/embedded-linux-diploma/bash/assignment1/Downloads/ --path

if [ -d "$directory_path" ]; then
    # Loop through the files in the directory
    for item in $(ls "$directory_path"); do
if [[ "$item" == *.* ]]; then 
    echo "The file $item contains a dot."
    extension="${item##*.}"
#check if there is an folder with this extension already craeted or not
if [ -d "$extension" ]; then
    echo "Directory extension already exists."
else
   echo "Directory extension does not exist."
      mkdir "$1"/"$extension"        #make dir with extension name 
      echo "Directory extension $extension created."
fi
    
    mv "$1"/"$item" "$1"/"$extension" #move the file to it 
       

else
    echo "The file $item does not contain a dot."
fi

        
    done
else
    echo "Directory does not exist: $directory_path"
fi