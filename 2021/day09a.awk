#!/usr/bin/gawk -f

##
## something is wrong :(
##

function haslower(data, x, y,    pos, ret) {
  pos = data[y][x]

  if ( (x > 1)      && (data[y][x-1] < pos) ) ret++
  if ( (x < width)  && (data[y][x+1] < pos) ) ret++
  if ( (y > 1)      && (data[y-1][x] < pos) ) ret++
  if ( (y < height) && (data[y+1][x] < pos) ) ret++

  return ret
}

{
  data[NR][1]
  split($0, data[NR], "")
}

END {
  height = NR
  width = length($0)

#  printf("%dx%d\n", width, height)
#  for (y=1; y<=height; y++) {
#    for (x=1; x<=width; x++)
#      printf("%d", data[y][x])
#    printf("\n")
#  }

  for (y=1; y<=height; y++) {
    for (x=1; x<=width; x++) {
      if (haslower(data, x, y) == 0) {
#        printf("pos(%3d,%3d) -> %4d + (%d + 1) = %4d\n", x,y, answer, data[y][x], answer + (data[y][x] + 1))
        answer += (data[y][x] + 1)
      }
    }
  }

  print answer
}
