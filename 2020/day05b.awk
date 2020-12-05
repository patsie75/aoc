#!/usr/bin/awk -f

## binary to decimal converter
function bin2dec(str,    dec) {
  while (str) {
    dec = dec * 2 + ( (substr(str, 1, 1) ~ /B|R/) ? 1 : 0)
    str = substr(str, 2)
  }
  return(dec)
}

BEGIN { min = 10000000 }

{
  # get row, seat and seat ID
  row = bin2dec(substr($0, 1, 7))
  col = bin2dec(substr($0, 8, 3))
  seatid = row * 8 + col

  # find smallest and biggest seat ID
  min = (seatid < min) ? seatid : min
  max = (seatid > max) ? seatid : max

  # seat is occupied
  occupied[seatid] = 1
}

END {
  # find unoccupied seat over all available seats
  for (seatid=(min+1); seatid<max; seatid++)
    if (! occupied[seatid])
      printf("Your seat ID: %d\n", seatid)
}
