#!/usr/bin/awk -f

function doflash(octo, x, y) {
  if ((y > 0) && (x > 0))          octo[(x-1),(y-1)]++
  if  (y > 0)                      octo[(x+0),(y-1)]++
  if ((y > 0) && (x < width))      octo[(x+1),(y-1)]++

  if (x > 0)                       octo[(x-1),(y+0)]++
  if (x < width)                   octo[(x+1),(y+0)]++

  if ((y < height) && (x > 0))     octo[(x-1),(y+1)]++
  if  (y < height)                 octo[(x+0),(y+1)]++
  if ((y < height) && (x < width)) octo[(x+1),(y+1)]++
}

BEGIN { FS="" }

{
  # read octopus data
  y = (NR - 1)
  for (x=0; x<NF; x++)
    octo[x,y] = $(x+1)
}

END {
  width = NF
  height = NR

  for (step=1; step<=100; step++) {
    flashing = 1

    # increase each value and reset flashing
    for (i in octo) {
        octo[i]++
        flash[i] = 0
    }

    # flash each value once
    while (flashing) {
      flashing = 0
      for (y=0; y<height; y++)
        for (x=0; x<width; x++)
          if ((octo[x,y] > 9) && (flash[x,y] == 0) ) {
            flashing = flash[x,y] = 1
            doflash(octo, x, y)
            answer++
          }
    }

    # reset values 
    for (i in octo)
      if (octo[i] > 9) octo[i] = 0

#    # display new status
#    for (y=0; y<height; y++) {
#      for (x=0; x<width; x++)
#        printf("%d", octo[x,y])
#      printf("\n")
#    }

    # print answer for this step
    printf("step #%d %d\n", step, answer)
  }
}
