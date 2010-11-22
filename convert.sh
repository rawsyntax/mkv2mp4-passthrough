#!/usr/bin/env bash
fname=$1

if [ -f $1 ] ; then
    filename=$(basename $fname)
    extension=${filename##*.}
    name=${filename%.*}
    echo "converting ${name} to mp4"
    `mkvextract tracks ${fname} 1:${name}.h264 2:${name}.ac3 > /dev/null 2>&1`
    `a52dec ${name}.ac3 -o wavdolby > ${name}.wav`
    `faac ${name}.wav > /dev/null 2>&1`
    FPS=`mediainfo --Inform=Video\;%FrameRate% "${fname}"`
    `MP4Box -add ${name}.aac -add ${name}.h264 -fps $FPS ${name}.mp4 > /dev/null 2>&1`
    `rm ${name}.aac ${name}.ac3 ${name}.h264 ${name}.wav`
fi
