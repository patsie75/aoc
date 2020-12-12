#!/usr/bin/awk -f

function abs(a) { return (a < 0) ? -a : a }

BEGIN {
  ## define out compass directions
  compass[0]   = "N"
  compass[90]  = "E"
  compass[180] = "S"
  compass[270] = "W"

  ## initial bearing (90 == E)
  dir = 90
}

{
  ## get instruction and value from our command
  instr = substr($1, 1, 1)
  value = substr($1, 2)

  ## N, E, S, W move in that direction
  if (instr == "N") lat -= value
  if (instr == "S") lat += value
  if (instr == "E") lon += value
  if (instr == "W") lon -= value

  ## L, R turn the direction/bearing
  if (instr == "L") dir -= value
  if (instr == "R") dir += value

  ## make sure we stay in 0-360 values
  while (dir < 0) dir += 360
  dir = dir % 360

  ## F moves forward in direction/bearing
  if (instr == "F") {
    if (compass[dir] == "N") lat -= value
    if (compass[dir] == "S") lat += value
    if (compass[dir] == "E") lon += value
    if (compass[dir] == "W") lon -= value
  }
}

END {
  printf("\nAnswer: %d + %d == %d\n", abs(lon), abs(lat), abs(lon) + abs(lat))
}
