#!/usr/bin/env bash

if [ -f $1 ] ; then
    filename=$(basename $1)
    extension=${filename##*.}
    name=${filename%.*}
    video=`mediainfo --Inform=Video\;%ID% "${fname}"`
    audio=`mediainfo --Inform=Audio\;%ID% "${fname}"`
    fps=`mediainfo --Inform=Video\;%FrameRate% "${fname}"`
    `mkvextract tracks ${fname} ${video}:${name}.h264 ${audio}:${name}.ac3`
    `a52dec ${name}.ac3 -o wavdolby > ${name}.wav`
    `faac ${name}.wav -o ${name}.m4a`
    `MP4Box -add ${name}.m4a -add ${name}.h264 -fps $fps ${name}.mp4`
    `rm ${name}.m4a ${name}.ac3 ${name}.h264 ${name}.wav ${name}.mkv`
fi
