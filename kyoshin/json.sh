#!/usr/local/bin/bash
host=localhost
targetnetwork=auhome
if [[ `networksetup -getairportnetwork en1` == *$targetnetwork* ]]; then
  data=$(curl -s 'http://www.kmoni.bosai.go.jp/webservice/hypo/eew/'$(date +%Y%m%d%H%M%S)'.json')
  if [[ -z `echo $data|jq -r '.report_id'` ]]; then
    oscer $host 60000 /status ok
  else
    afplay /Users/hibiki/cool-desktop/kyoshin/notice.aiff&
    oscer $host 60000 /status info
#     oscer $host 60000 /status info
#     say "地震発生、最大震度$(echo $data|jq -r '.calcintensity')、震源地$(echo $data|jq -r '.region_name')"
  fi
else
  oscer $host 60000 /status offline
fi