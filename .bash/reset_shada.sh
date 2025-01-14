#!/bin/bash

path="$HOME/AppData/Local/nvim-data/shada"

# shadaz='main.shada.tmp.z'
files_to_delete=$(ls "$path")

for i in $files_to_delete; do 
    rm -v "${path}/${i}"
done

# mv -v "${path}${shadaz}" "${path}main.shada"
