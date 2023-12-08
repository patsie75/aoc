#!/usr/bin/gawk -f

BEGIN {
  FS = "[:|]"
}

function contains(val, arr,    i) {
  for (i in arr) 
    if (arr[i] == val) return 1
  return 0
}

{
  score = 0

  n = split($2, have, " ")
  m = split($3, wins, " ")

  for (i=1; i<=n; i++)
    if (contains(have[i], wins))
      score = score ? (score * 2) : 1

  answer += score
}

END {
  print answer
}
