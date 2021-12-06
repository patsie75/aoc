#!/usr/bin/awk -f

BEGIN { FS="," }

# get initial state
{ for (i=1; i<=NF; i++) day[$i]++ }

END {
  # loop over 256 days
  for (d=1; d<=256; d++) {
    tmp = day[0]

    # shift all fish counts one day
    for (i=0; i<8; i++)
      day[i] = day[i+1]

    # day[0] is reset to day[6]
    day[6] += tmp

    # day[8] spawns day[0] new fishes
    day[8] = tmp
  }

  # count all fishes
  for (i=0; i<=8; i++)
    sum += day[i]
  printf("%d\n", sum)
}
