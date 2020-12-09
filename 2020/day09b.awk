#!/usr/bin/awk -f

function min(a, b) { return (a<b) ? a : b }
function max(a, b) { return (a>b) ? a : b }

function find(data, value,    i, j, minim, maxim, sum) {
  ## loop over all data
  for (i=1; i<NR; i++) {
    minim = maxim = sum = data[i]

    ## search from this point to end of data
    for (j=(i+1); j<=NR; j++) {
      ## add next value to sum and check for overflow
      sum += data[j]
      if (sum > value) break

      ## update minimum and maximum values
      minim = min(minim, data[j])
      maxim = max(maxim, data[j])

      ## found our value
      if (sum == value)
        return(minim + maxim)
    }
  }

}

{
  ## collect data
  data[NR] = $1
}

END {
  ## find and print answer
  answer = find(data, 32321523)
  printf("Answer: %d\n", answer)
}
