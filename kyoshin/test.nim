import httpClient, times, os, json, math, uri, tjma2001 as jma
from strutils import parseInt, parseFloat, parseBool, replace
from unicode import runeAt, toUTF8
# {.push header:"<lo/lo.h>".}

# type lo_address {.importc: "lo_address".} = object

# proc lo_address_new(formatstr: cstring): lo_address {.importc: "lo_address_new", varargs.}
# proc lo_send(target: lo_address, formatstr: cstring): void {.importc: "lo_send", varargs.}

# {.pop.}

# let t = lo_address_new("iMac216.local", "60000")
# lo_send(t, "/status", "s", "emergency")

var host: string = "localhost"
var port: string = "60000"
var targetNetwork: string = "auhome"
const url = "http://www.kmoni.bosai.go.jp/webservice/hypo/eew/"

if paramCount() >= 1:
  host = paramStr(1)
if paramCount() >= 2:
  port = paramStr(2)
if paramCount() >= 3:
  targetNetwork = paramStr(3)
var time = getTime()
var millisec = time.format("fff").parseInt
let http = newHttpClient()
var data = http.getContent(url & time.format("yyyyMMddHHmmss") & ".json").parseJson
var command: int

var dealingID: string
var cautionDoneID: string
var training: bool

type
  Status = enum
    offline = 0,
    ok,
    info,
    emergency

var status: Status = offline
var eta: float
var originTime: int
var epicenter: string
const latitudeHere = 35.4269299222268
const longitudeHere = 139.5540683599317
const macSystemOrigin = 978307200

proc calcDistance(lat1: float, lon1: float, lat2: float, lon2: float): float =
  # https://qiita.com/chiyoyo/items/b10bd3864f3ce5c56291
  let radLat1 = degToRad(lat1)
  let radLon1 = degToRad(lon1)
  let radLat2 = degToRad(lat2)
  let radLon2 = degToRad(lon2)

  let radLatAve = (radLat1 + radLat2) / 2.0

  const a = 6377397.155 # 赤道半径
  const e2 = 0.00667436061028297 # 第一離心率^2
  const a1e2 = 6334832.10663254 # 赤道上の子午線曲率半径

  let w2 = 1.0 - e2 * sin(radLatAve)^2
  let m= a1e2 / sqrt(w2)^2 # 子午線曲率半径
  let n = a / sqrt(w2) # 卯酉線曲率半径

  let t1 = m * (radLat1 - radLat2)
  let t2 = n * cos(radLatAve) * (radLon1 - radLon2)
  result = sqrt(t1^2 + t2^2) / 1000 # return in Kilometers

echo calcDistance(latitudeHere, longitudeHere, "38.3".parseFloat, "141.7".parseFloat)

eta = jma.t3resolve("50km".replace("km").parseInt, calcDistance(latitudeHere, longitudeHere, "38.3".parseFloat, "141.7".parseFloat))

echo eta