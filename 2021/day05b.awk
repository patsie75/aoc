#!/usr/bin/awk -f

function min(a, b) { return (a < b) ? a : b }
function max(a, b) { return (a > b) ? a : b }
function abs(a) { return (a < 0) ? -a : a }

{
  # convert data into coordinates
  split($1, p1, ",")
  x1 = p1[1]
  y1 = p1[2]

  split($3, p2, ",")
  x2 = p2[1]
  y2 = p2[2]

  # calculate max map with and height
  width  = max(x1, max(x2, width) )
  height = max(y1, max(y2, height) )

  if (abs(x1-x2) >= abs(y1-y2)) {
    # horizontal line
    direction = 1
    a1=x1; a2=x2; b1=y1; b2=y2
  } else {
    # vertical line
    direction = 0
    a1=y1; a2=y2; b1=x1; b2=x2
  }

  # swap points if a1 > a2
  if (a1 > a2) {
    tmp=a1; a1=a2; a2=tmp
    tmp=b1; b1=b2; b2=tmp
  }

  # calculate slope/delta
  m = (a2-a1) ? (b2-b1) / (a2-a1) : 0

  j = b1
  # draw either a "horizontal" or "vertical" line
  for (i=a1; i<=a2; i++) {
    map[(direction ? j : i),(direction ? i : j)]++
    j += m
  }

}

END {
  # count all map coordinates 2 or more
  for (y=0; y<=height; y++)
    for (x=0; x<=width; x++)
      if (map[y,x] >= 2) answer++

  print answer
}
