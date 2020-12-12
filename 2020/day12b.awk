#!/usr/bin/awk -f

function abs(a) { return (a < 0) ? -a : a }

function rotate(degrees,    i, tmp) {
  if (degrees < 0) {
    ## turn left (lat = -lon; lon = lat)
    for (i=degrees; i<0; i+=90) {
      tmp = way["lat"]
      way["lat"] = -way["lon"]
      way["lon"] = tmp
    }
  } else {
    ## turn right (lat = lon; lon = -lat)
    for (i=0; i<degrees; i+=90) {
      tmp = way["lat"]
      way["lat"] = way["lon"]
      way["lon"] = -tmp
    }
  }
}

BEGIN {
  ## define out compass directions
  compass[0]   = "N"
  compass[90]  = "E"
  compass[180] = "S"
  compass[270] = "W"

  way["lon"] = 10
  way["lat"] = -1
}

{
  ## get instruction and value from our command
  instr = substr($1, 1, 1)
  value = substr($1, 2)

  ## N, E, S, W move waypoint in that direction
  if (instr == "N") way["lat"] -= value
  if (instr == "S") way["lat"] += value
  if (instr == "E") way["lon"] += value
  if (instr == "W") way["lon"] -= value

  ## rotate waypoint either left or right
  if (instr == "L") rotate( -int(value) )
  if (instr == "R") rotate(  int(value) )

  ## F moves forward "value" times towards waypoint
  if (instr == "F") {
    lon += (way["lon"] * value)
    lat += (way["lat"] * value)
  }
}

END {
  printf("\nAnswer: %d + %d == %d\n", abs(lon), abs(lat), abs(lon) + abs(lat))
}
