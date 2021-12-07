#!/usr/bin/awk -f

function abs(a) { return (a<0) ? -a : a }
function min(a, b) { return (a<b) ? a : b }
function max(a, b) { return (a>b) ? a : b }

{ positions = split($0, crab, ",") }

END {
  answer = 9999999999

  for (i=1; i<=positions; i++) {
    sum = 0
    for (j=1; j<=positions; j++) {
      tmp = abs(crab[j] - i)
      sum += ((1+tmp)*tmp) / 2
    }

    answer = min(answer, sum)
  }

  printf("%d\n", answer)
}
