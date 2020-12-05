#!/usr/bin/awk -f

## binary to decimal converter
function bin2dec(str,    dec) {
  while (str) {
    dec = dec * 2 + ( (substr(str, 1, 1) ~ /B|R/) ? 1 : 0)
    str = substr(str, 2)
  }
  return(dec)
}

{
  # get row, seat and seat ID
  row = bin2dec(substr($0, 1, 7))
  col = bin2dec(substr($0, 8, 3))
  seatid = row * 8 + col

  # find biggest seat ID
  max = (seatid > max) ? seatid : max
}

END {
  printf("Highest seat ID: %d\n", max)
}
