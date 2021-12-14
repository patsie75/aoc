#!/bin/awk -f

function bond(poly, pairs,    newpoly, len, e1, e2, pair) {
  len = length(poly)
  e1 = substr(poly, 1, 1)

  for (i=2; i<=len; i++) {
    e2 = substr(poly, i, 1)
    pair = e1""e2

    if (pair in pairs)
      newpoly = newpoly e1 pairs[pair]
    else
      newpoly = newpoly e1

    e1 = e2
  }

  return newpoly e2
}

function most(poly,    elem, e, cnt, max) {
  max = 0

  split(poly, elem, "")
  for (e in elem) cnt[elem[e]]++
  for (e in cnt) max = (cnt[e] > max) ? cnt[e] : max

  return max
}

function least(poly,    elem, e, cnt, min) {
  min = 9999999999

  split(poly, elem, "")
  for (e in elem) cnt[elem[e]]++
  for (e in cnt) min = (cnt[e] < min) ? cnt[e] : min

  return min
}

(NR == 1) { poly = $1 }
(NR  > 2) { pairs[$1] = $3 }

END {
  for (seq=1; seq<=10; seq++)
    poly = bond(poly, pairs)

  print most(poly) - least(poly)
}
