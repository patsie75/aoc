#!/bin/awk -f

{
  bits = split($1, data, "")
  for (bit=1; bit<=bits; bit++)
    if (data[bit] == "1") { count[bit]++ }
}

END {
  for (bit=1; bit<=bits; bit++) {
    gamma *= 2
    epsilon *= 2
    if (count[bit] > (NR/2))
      gamma += 1
    else
      epsilon += 1
  }

  printf("%d\n", gamma * epsilon)
}
