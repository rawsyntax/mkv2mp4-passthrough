#!/usr/bin/env bash
fname=$1

if [ -f $1 ] ; then
    filename=$(basename $fname)
    extension=${filename##*.}
    name=${filename%.*}
    VIDEO=`mediainfo --Inform=Video\;%ID% "${fname}"`
    AUDIO=`mediainfo --Inform=Audio\;%ID% "${fname}"`
    `mkvextract tracks ${fname} ${VIDEO}:${name}.h264 ${AUDIO}:${name}.ac3`
    `a52dec ${name}.ac3 -o wavdolby > ${name}.wav`
    `faac ${name}.wav -o ${name}.m4a`
    FPS=`mediainfo --Inform=Video\;%FrameRate% "${fname}"`
    `MP4Box -add ${name}.m4a -add ${name}.h264 -fps $FPS ${name}.mp4`
    `rm ${name}.m4a ${name}.ac3 ${name}.h264 ${name}.wav ${name}.mkv`
fi
