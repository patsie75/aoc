#!/bin/awk -f

BEGIN {
  digits["0"]   = 0
  digits["1"]   = digits["one"]   = 1
  digits["2"]   = digits["two"]   = 2
  digits["3"]   = digits["three"] = 3
  digits["4"]   = digits["four"]  = 4
  digits["5"]   = digits["five"]  = 5
  digits["6"]   = digits["six"]   = 6
  digits["7"]   = digits["seven"] = 7
  digits["8"]   = digits["eight"] = 8
  digits["9"]   = digits["nine"]  = 9
}

{
  first = ""

  for (i=1; i<=length($0); i++) {           # pass over each character in line
    for (j in digits) {                     # check each 'digit[]'
      if (substr($0, i, length(j)) == j) {  # against position in string
        if (!first) first = digits[j]       # fill first
        last = digits[j]                    # fill last
      }
    }
  }

  sum += (first "" last)                    # add to sum
}

END {
  print sum
}
