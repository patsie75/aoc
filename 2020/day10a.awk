#!/usr/bin/awk -f

function max(a, b) { return (a > b) ? a : b }

{
  data[$1] = 1
  maxim = max(maxim, $1)
}

END {
  jolts = 0
  three = 1

  while (jolts < maxim) {
    if (data[jolts+1]) { jolts += 1; one++; continue }
    if (data[jolts+3]) { jolts += 3; three++; continue }
  }

  printf("Answer: %d (%d x %s)\n", one * three, one, three)
}
