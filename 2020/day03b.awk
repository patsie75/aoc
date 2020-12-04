#!/usr/bin/awk -f

{
  # read map data
  map[NR] = $0
}

END {
  answer = 1
  split("1 3 5 7 1", dx)
  split("1 1 1 1 2", dy)

  for (loop=1; loop<=length(dx); loop++) {
    # reset counters
    x = 0
    hits = 0

    # go down dy line/row
    for (y=1+dy[loop]; y<=NR; y+=dy[loop]) {
      # move dx positions right and wrap infinitely
      x += dx[loop]
      x %= length(map[y])
  
      # check if new position is a tree (#)
      # substr() indexes from position 1, so add 1 to x)
      if (substr(map[y], (x+1), 1) == "#")
        hits++
    }
  
    # print answer
    printf("loop #%s: Trees hit = %4d\n", loop, hits)
    answer *= hits
  }

  printf("answer = %d\n", answer)
}
