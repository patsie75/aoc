#!/usr/bin/awk -f

{
  # read map data
  map[NR] = $0
}

END {
  # go down 1 line/row
  for (y=2; y<=NR; y++) {
    # move 3 positions right and wrap infinitely
    x += 3
    x %= length(map[y])

    # check if new position is a tree (#)
    # substr() indexes from position 1, so add 1 to x)
    if (substr(map[y], (x+1), 1) == "#")
      hits++
  }

  # print answer
  printf("Trees hit: %d\n", hits, y)
}
