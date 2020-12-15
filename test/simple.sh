#!/bin/bash
#
# exercise bidirectionally
#
source common.source
PUB_TYPE=${1:-Shape1Default}
SUB_TYPE=${2:-Shape1Default}

OUT=$BASE.rtipub.$PUB_TYPE.$SUB_TYPE
if [ -e "$OUT.pub" ]; then 
  echo $OUT.pub exists, quitting
  exit 0
fi
script -qf -c "$TOC -sub -type $SUB_TYPE                       " $OUT.sub &
script -qf -c "$RTI -pub -type $PUB_TYPE -samples 5 -seconds 10" $OUT.pub &

sleep 6
kill $(list_descendants $$)

#
# Now swap the pub/sub role
OUT=$BASE.tocpub.$PUB_TYPE.$SUB_TYPE
script -qf -c "$RTI -sub -type $SUB_TYPE -samples 5 -seconds 10" $OUT.sub &
script -qf -c "$TOC -pub -type $PUB_TYPE                       " $OUT.pub &

sleep 6
kill $(list_descendants $$)

