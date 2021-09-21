#!/bin/bash

#########################################################################################

SERVICES=('nginx' 'mysql')

########################################################################################

#curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'" }'

#########################################################################################

TAGS='__ENTER_TAGS_DIR_/tags'

#########################################################################################

SLACK= ENTER SLACK CHANNEL INTEGRATION DETAILS




for i in "${SERVICES[@]}"
 do
         `pgrep $i >/dev/null 2>&1`
         STATS=$(echo $?)

         if  [[ $STATS == 0 ]] && [[ -f "$TAGS$i"  ]]
         then
                 sleep 2

         elif [[ $STATS == 0  ]] && [[ ! -f "$TAGS$i"  ]]
         then
                 touch $TAGS$i
                 MESSAGE_TAG="## Linux Srvs Chkr ## >>  $i was up and no tag was in place. -  A tag for $i was created $(hostname) $(date) "
                 curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_TAG}"'" }' $SLACK
                 sleep 2

         elif [[ $STATS == 1  ]] && [[ ! -f "$TAGS$i"   ]]
         then
                sleep 2
                systemctl restart $i
                `pgrep $i >/dev/null 2>&1`
                RESTART=$(echo $?)

                if [[ $RESTART == 0  ]]
                then
                        MESSAGE_UP="## Linux Srvs Chkr ## >>  $i was down, but I was able to restart it on Server >> $(hostname) $(date)  "
                        curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_UP}"'" }' $SLACK
                        touch $TAGS$i
                        sleep 2
                fi

        elif [[ $STATS == 1  ]] && [[ -f "$TAGS$i"  ]]
        then
                systemctl restart $i
                `pgrep $i >/dev/null 2>&1`
                RESTART=$(echo $?)

                if  [[ $RESTART == 0  ]]
                then
                        MESSAGE_UP="## Linux Srvs Chkr ## >>  $i was down, but I was able to restart it on Server >> $(hostname) $(date)  "
                        curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_UP}"'" }' $SLACK
                        sleep 2
                else
                        MESSAGE_DOWN="## Linux Srvs Chkr ##  >>  $i is down on Server >> $(hostname)  at $(date)  "
                        rm $TAGS$i
                        curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_DOWN}"'" }' $SLACK
                        sleep 2
                fi
         fi
 done
exit 0;

