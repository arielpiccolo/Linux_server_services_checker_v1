#!/bin/bash

#########################################################################################

SERVICES=('nginx' 'mysql')

########################################################################################

#curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'" }'

#########################################################################################






for i in "${SERVICES[@]}"
 do
         `pgrep $i >/dev/null 2>&1`
         STATS=$(echo $?)

         if  [[ $STATS == 0 ]] && [[ -f "/root/scripts/srv_stts_ckr/tags/$i"  ]]
         then
                 sleep 2

         elif [[ $STATS == 0  ]] && [[ ! -f "/root/scripts/srv_stts_ckr/tags/$i"   ]]
         then
                 touch /root/scripts/srv_stts_ckr/tags/$i
                 MESSAGE_TAG="## Linux Srvs Chkr ## >>  $i was up and no tag was in place. -  A tag for $i was created $(hostname) $(date) "
                 curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_TAG}"'" }' $A $S
                 sleep 2

         elif [[ $STATS == 1  ]] && [[ ! -f "/root/scripts/srv_stts_ckr/tags/$i"   ]]
         then
                sleep 2
                systemctl restart $i
                `pgrep $i >/dev/null 2>&1`
                RESTART=$(echo $?)

                if [[ $RESTART == 0  ]]
                then
                        MESSAGE_UP="## Linux Srvs Chkr ## >>  $i was down, but I was able to restart it on Server >> $(hostname) $(date)  "
                        curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_UP}"'" }' $A $S
                        touch /root/scripts/srv_stts_ckr/tags/$i
                        sleep 2
                fi

        elif [[ $STATS == 1  ]] && [[ -f "/root/scripts/srv_stts_ckr/tags/$i"   ]]
        then
                systemctl restart $i
                `pgrep $i >/dev/null 2>&1`
                RESTART=$(echo $?)

                if  [[ $RESTART == 0  ]]
                then
                        MESSAGE_UP="## Linux Srvs Chkr ## >>  $i was down, but I was able to restart it on Server >> $(hostname) $(date)  "
                        curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_UP}"'" }' $A $S
                        sleep 2
                else
                        MESSAGE_DOWN="## Linux Srvs Chkr ##  >>  $i is down on Server >> $(hostname)  at $(date)  "
                        rm /root/scripts/srv_stts_ckr/tags/$i
                        curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"${i}"'", "text": "'"${MESSAGE_DOWN}"'" }' $A $S
                        sleep 2
                fi
         fi
 done
exit 0;
