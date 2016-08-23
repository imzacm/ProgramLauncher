#! /bin/bash

cd source/menu

for dir in `find . -type d`
do
  cd $dir
  . ../../default.conf
  . menu.conf
  for f in *.*
  do
    filename=$(basename "$f")
    extension="${filename##*.}"
    filename="${filename%.*}"
    case $extension in
      "cc"|"cpp"|"c")
        g++ -c $filename.$extension $cxflags -o $filename.obj
        ;;
    esac
  done
  num_files=$(ls -l log* | wc -l)
  if [ -z "$output" ]
  then
    output="$name"
  fi
  if [ $num_files -gt 1 ]
  then
    files=(./*.obj)
    g++ -o $output "${files[@]}"
  fi
  cd ../
done
