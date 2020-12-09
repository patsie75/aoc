#!/usr/bin/awk -f

function find(data, preamble,    i, j) {
  ## look through previous "preamble" values
  for (i=(NR-preamble); i<(NR-1); i++)
    for (j=(i+1); j<NR; j++)
      ## value found
      if ( (data[i] + data[j]) == data[NR] )
        return(1)

  return(0)
}

{
  ## collect data
  data[NR] = $1
}

## start looking for records > 25
(NR > 25) {
  if ( ! find(data, 25) ) {
    printf("Answer: %d\n", data[NR])
    exit 0
  }
}
