#!/usr/bin/env bash

# Copy pack
rm -rf scuffed_pack/
cp -r ./default_pack/ scuffed_pack/

## MAKE THE SOUND PACK ## 
tmp_audio="/tmp/tmp_audio.ogg"
bitrate="32k"
sample_rate="8000"

for sound in $(find scuffed_pack/ -type f -name "*.ogg"); do
    echo $sound
    ffmpeg -i $sound -c:a libvorbis -ab $bitrate -ar $sample_rate $tmp_audio -loglevel quiet
    mv $tmp_audio $sound
done


## MAKE THE TEXTURE PACK ## 
quality="7%"
upscale="200%"
tmp_color="/tmp/tmp_color.jpg"
tmp_alpha="/tmp/tmp_alpha.jpg"

# Exclude spectific paths
rm -r scuffed_pack/assets/minecraft/textures/colormap/

# Loop over PNG images
for image in $(find scuffed_pack/ -type f -name "*.png"); do
    echo $image
    # Extract color channels and jpeg
    convert $image -resize $upscale -quality $quality $tmp_color

    # Extract alpha channel (with nearest resize)
    convert $image -resize $upscale -interpolate Nearest -filter point -alpha extract $tmp_alpha

    # Merge alpha and color channels
    convert $tmp_color $tmp_alpha -alpha off -compose CopyOpacity -composite $image
    #rm $tmp_color $tmp_alpha 
done

# Save to zip
#zip -r scuffed.zip scuffed_pack/*
#rm -rf scuffed_pack/
