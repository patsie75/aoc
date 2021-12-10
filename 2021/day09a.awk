#!/usr/bin/gawk -f

function islowest(data, x, y,    pos, ret) {
  pos = data[y][x]

  if ( (x > 1)      && (data[y][x-1] <= pos) ) return 0
  if ( (x < width)  && (data[y][x+1] <= pos) ) return 0
  if ( (y > 1)      && (data[y-1][x] <= pos) ) return 0
  if ( (y < height) && (data[y+1][x] <= pos) ) return 0

  return 1
}

{
  data[NR][1]
  split($0, data[NR], "")
}

END {
  height = NR
  width = length($0)

  for (y=1; y<=height; y++)
    for (x=1; x<=width; x++)
      if (islowest(data, x, y))
        answer += (data[y][x] + 1)

  print answer
}
