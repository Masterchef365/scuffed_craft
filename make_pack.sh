#!/usr/bin/env bash
quality="20%"
tmp="/tmp/out.jpg"
rm -rf scuffed_pack/
cp -r ./default_pack/ scuffed_pack/
for image in $(find scuffed_pack/ -type f -name "*.png"); do
    echo $image
    convert $image -resize 200% -quality $quality $tmp
    convert $tmp $image
done
zip -r scuffed.zip scuffed_pack/
rm -rf scuffed_pack/
