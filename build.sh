#! /bin/bash

#for folders in menu,
#  read menu.conf and set vars
#  for src files in each folders
#    switch file extension, case extension vars set in conf files
#      execute compiler for language
#  if src files > 1 then link all output files
#  rename out file to output variable for folder

cd source/menu
. ../default.conf

for dir in `find . -type d`
do
  cd $dir
  . menu.conf
  for f in *.*
  do
    filename=$(basename "$f")
    extension="${filename##*.}"
    filename="${filename%.*}"
    case $extension in
      $cc|$cpp)
        g++ $filename.$extension $cxflags
        ;;
      $c)
        gcc $filename.$extension $cxflags
        ;;
    esac
  done
  cd ../
done

echo $cc
echo $cpp
echo $c
