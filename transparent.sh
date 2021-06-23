#!/usr/bin/env bash
quality="10%"
upscale="200%"
tmp_color="/tmp/tmp_color.jpg"
tmp_alpha="/tmp/tmp_alpha.jpg"
rm -rf scuffed_pack/
cp -r ./default_pack/ scuffed_pack/
for image in $(find scuffed_pack/ -type f -name "*.png"); do
    echo $image
    convert $image -resize $upscale -quality $quality $tmp_color
    convert $image -resize $upscale -interpolate Nearest -filter point -alpha extract $tmp_alpha
    convert $tmp_color $tmp_alpha -alpha off -compose CopyOpacity -composite $image
    #rm $tmp_color $tmp_alpha 
done
zip -r scuffed.zip scuffed_pack/*
#rm -rf scuffed_pack/
