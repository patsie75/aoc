#!/bin/awk -f

function lifesupport(inputdata, gastype,    i, n, bitpos, bit, workdata, tmpdata, result) {
  bitpos = 0

  # copy input data into work array
  for (i=1; i<=length(inputdata); i++)
    workdata[i] = inputdata[i]

  # repeat until all bits exhausted or 1 element left
  while ( (length(workdata) > 1) && (++bitpos <= length(workdata[1])) ) {

    # count 0 and 1 bits in column "bitpos"
    delete bit
    for (i=1; i<=length(workdata); i++)
      bit[substr(workdata[i], bitpos, 1)]++

    # append least/most counted bit, depending on type of gas
    if (gastype == "oxygen")
      result = (bit["0"] > bit["1"]) ? result"0" : result"1"
    else
      result = (bit["0"] <= bit["1"]) ? result"0" : result"1"

    n = 0
    # filter new results into temp array
    for (i=1; i<=length(workdata); i++)
      if (substr(workdata[i], 1, bitpos) == result)
        tmpdata[++n] = workdata[i]
    delete workdata

    # copy temp array back to work array
    for (i=1; i<=length(tmpdata); i++)
      workdata[i] = tmpdata[i]
    delete tmpdata
  }

  return workdata[1]
}

function bintodec(bin,    result) {
  while ( length(bin) ) {
    result *= 2
    result += substr(bin,1,1)
    bin = substr(bin,2)
  }
  return result
}


{
  # store data
  data[NR] = $1
}

END {
  oxygen = lifesupport(data, "oxygen")
  co2 = lifesupport(data, "co2")

  printf("%d\n", bintodec(oxygen) * bintodec(co2) )
}
