#!/usr/bin/env bash
fname=$1

if [ -f $1 ] ; then
    filename=$(basename $fname)
    extension=${filename##*.}
    name=${filename%.*}
    echo "converting ${name} to mp4"
    VIDEO_TRACK=`mediainfo --Inform=Video\;%ID% "${fname}"`
    AUDIO_TRACK=`mediainfo --Inform=Audio\;%ID% "${fname}"`
    `mkvextract tracks ${fname} ${VIDEO_TRACK}:${name}.h264 ${AUDIO_TRACK}:${name}.ac3 > /dev/null 2>&1`
    `a52dec ${name}.ac3 -o wavdolby > ${name}.wav`
    `faac ${name}.wav -o ${name}.m4a`
    FPS=`mediainfo --Inform=Video\;%FrameRate% "${fname}"`
    `MP4Box -add ${name}.m4a -add ${name}.h264 -fps $FPS ${name}.mp4 > /dev/null 2>&1`
    `rm ${name}.m4a ${name}.ac3 ${name}.h264 ${name}.wav ${name}.mkv`
fi
