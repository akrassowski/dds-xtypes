#!/bin/bash
#
# exercise bidirectionally
#
source common.source
PUB_TYPE=${1:-Shape1Default}
SUB_TYPE=${2:-Shape1Default}

OUT=result.rtipub.$PUB_TYPE.$SUB_TYPE
xterm -e "script -qf -c '$TOC -sub -type $SUB_TYPE' $OUT.sub; $SHELL" &
xterm -e "script -qf -c '$RTI -pub -type $PUB_TYPE' $OUT.pub ; $SHELL" &

sleep 5
kill $(list_descendants $$)

#
# Now swap the pub/sub role
OUT=result.tocpub.$PUB_TYPE.$SUB_TYPE
xterm -e "script -qf -c '$RTI -sub -type $SUB_TYPE' $OUT.sub; $SHELL" &
xterm -e "script -qf -c '$TOC -pub -type $PUB_TYPE' $OUT.pub; $SHELL" &

sleep 5
kill $(list_descendants $$)




