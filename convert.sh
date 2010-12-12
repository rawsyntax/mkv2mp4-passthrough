#!/usr/bin/env bash

for f in *.mkv
do
    if [ -f $f ] ; then
        filename=$(basename $f)
        extension=${filename##*.}
        name=${filename%.*}
        video=`mediainfo --Inform=Video\;%ID% "${f}"`
        audio=`mediainfo --Inform=Audio\;%ID% "${f}"`
        fps=`mediainfo --Inform=Video\;%FrameRate% "${f}"`
        `mkvextract tracks ${f} ${video}:${name}.h264 ${audio}:${name}.ac3`
        `a52dec ${name}.ac3 -o wavdolby > ${name}.wav`
        `faac ${name}.wav -o ${name}.m4a`
        `MP4Box -add ${name}.m4a -add ${name}.h264 -fps $fps ${name}.mp4`
        `rm ${name}.m4a ${name}.ac3 ${name}.h264 ${name}.wav`
    fi
done
exit
