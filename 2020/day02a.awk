#!/usr/bin/awk -f

{
  # parse record fields
  split($1, range, "-")
  char = substr($2, 1, 1)
  n = split($3, passwd, "")

  count = 0
  # loop over password and count number of characters
  for (i=1; i<=n; i++) {
    if (passwd[i] == char)
      count++
  }

  # check if number of characters is within valid range
  if ( (count >= range[1]) && (count <= range[2]) )
    valid++
}

END {
  printf("Valid passwords: %d\n", valid)
}

