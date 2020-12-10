#!/usr/bin/gawk -f

{
  data[NR+1] = $1
  cache[$1] = 0
}

END {
  ## start with 0 jolts and sort data
  data[1] = 0
  asort(data)

  ## last element has 1 outcome
  cache[data[NR+1]] = 1

  ## reverse through all elements back to front
  for (i=NR+1; i>0; i--) {
    ## check 3 possible options
    for (x=1; x<4; x++)
      ## is option within range of 3
      if ( (data[i+x] - data[i]) < 4 )
        ## add all its parent options
        cache[data[i]] += cache[data[i+x]]

  }

  printf("answer: %d\n", cache[0])
}
