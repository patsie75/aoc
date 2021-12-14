#!/bin/awk -f

function bond(poly, pairs,     pair, e1, e2, newpoly) {
  # split one bond (AC) into two bonds -> ABC = (AB + BC)
  for (pair in poly) {
    e1 = (substr(pair, 1, 1))
    e2 = (substr(pair, 2, 1))

    newpoly[e1""pairs[pair]] += poly[pair] 
    newpoly[pairs[pair]""e2] += poly[pair] 
  }

  # copy new poly array back to old one
  delete poly
  for (pair in newpoly)
    poly[pair] = newpoly[pair]
}

## find the most common element
function minmax(poly, minormax,     pair, elem, e, e1, e2, min, max) {
  max = 0
  min = 999999999999999999999999999

  # create array of single elements
  for (pair in poly) {
    e1 = (substr(pair, 1, 1))
    e2 = (substr(pair, 2, 1))

    elem[e1] += poly[pair]
    elem[e2] += poly[pair]
  }

  # first and last character are not doubly present, so add them
  elem[first]++
  elem[last]++

  # find the min/maximum
  for (e in elem) {
    min = (elem[e] < min) ? elem[e] : min
    max = (elem[e] > max) ? elem[e] : max
  }

  # all elements are double, so divide by two
  return (minormax ~ /^min/) ? (min / 2) : (max / 2)
}

## get poly template start
(NR == 1) {
  len = length($1)
  first = e1 = substr($1, 1, 1)

  for (i=2; i<=len; i++) {
    e2 = substr($1, i, 1)
    poly[e1""e2]++
    e1 = e2
  }

  last = e2
}

## get all pair information
(NR  > 2) { pairs[$1] = $3 }

END {
  # do bonding sequence
  for (seq=1; seq<=40; seq++)
    bond(poly, pairs)

  # find the most and least common elements
  least = minmax(poly, "min")
  most  = minmax(poly, "max")

  printf("%d - %d = %d\n", most, least, most - least)
}
