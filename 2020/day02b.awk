#!/usr/bin/awk -f

{
  # parse record fields
  split($1, position, "-")
  char = substr($2, 1, 1)
  n = split($3, passwd, "")

  # check if character is at only one of the mentioned positions
  if ( (passwd[position[1]] == char) || (passwd[position[2]] == char) ) {
    if ( (passwd[position[1]] == char) && (passwd[position[2]] == char) )
      next
    valid++
  }
}

END {
  printf("Valid passwords: %d\n", valid)
}

