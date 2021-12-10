#!/usr/bin/awk -f

BEGIN { FS="|" }

{
  split($2, output, " ")

  for (i in output) {
    l = length(output[i])
    if ( (l == 2) || (l == 3) || (l == 4) || (l == 7) )
       answer++
  }
}

END {
  print answer
}
