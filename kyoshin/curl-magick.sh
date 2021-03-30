#!/bin/bash
ymd=$(date -v -2S +%Y%m%d)
hms=$(date -v -2S +%H%M%S)
set -o pipefail
curl http://www.kmoni.bosai.go.jp/data/map_img/RealTimeImg/jma_s/$ymd/$ymd$hms.jma_s.gif|/usr/local/bin/magick composite -compose dst-out ~/Cool-desktop/kyoshin/clip.png -matte - ~/Cool-desktop/kyoshin/data/img.png
curl_test=$?
if [ $curl_test = 0 ]; then
  echo 'Last updated at'
else
  echo 'Last tried at'
fi
date '+%Y/%m/%d %H:%M:%S'
#jsonを解析して、それを元にpsを処理するか決めるようにする。
if [ "$(curl http://www.kmoni.bosai.go.jp/new/data/map_img/PSWaveImg/eew/$ym$day/$ym$dhms.eew.gif -s -o ~/Cool-desktop/kyoshin/data/ps.gif -w '%{http_code}')" != "200" ];then
	cp ~/Cool-desktop/kyoshin/data/ps-trans.gif ~/Cool-desktop/kyoshin/data/ps.gif
fi
exit $curl_test
# echo -e "Last updated at\n"$(date -v -2S "+%Y/%-m/%-d %H:%M:%S")

#!/bin/bash
# set -o pipefail
# curl 'wttr.in/Yokohama?format=%l:!+?%c+%C!+?%t!+?%w!+?%p+%o'|sed -e 's/?/  /g'|tr '!' '\n'>~/Cool-desktop/Data/weather.txt
# echo ''>>~/Cool-desktop/Data/weather.txt
# curl 'wttr.in/Adachi?format=%l:!+?%c+%C!+?%t!+?%w!+?%p+%o'|sed -e 's/?/  /g'|tr '!' '\n'>>~/Cool-desktop/Data/weather.txt
# curl_test=$?
# if [ $curl_test = 0 ]; then
#   echo 'Last updated at'
# else
#   echo 'Last tried at'
# fi
# date '+%Y/%m/%d %H:%M:%S'
# exit $curl_test
# status = $?