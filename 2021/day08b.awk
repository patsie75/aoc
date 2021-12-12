#!/usr/bin/gawk -f

## sort array alphabetically
function astrsort(arr,    i) {
  for (i in arr)
    arr[i] = strsort(arr[i])
}

## sort letters in string alphabetically
function strsort(str,    n, tmp, i, ret) {
  n = split(str, tmp, "")
  asort(tmp)
  for (i=1; i<=n; i++)
    ret = ret tmp[i]
  return ret
}

## sort array by length of string
function alensort(arr,    swap, l, i, tmp) {
  swap = 1
  l = length(arr)

  while (swap) {
    swap = 0
    for (i=1; i<l; i++) {
      if (length(arr[i]) > length(arr[i+1])) {
        tmp = arr[i]
        arr[i] = arr[i+1]
        arr[i+1] = tmp
        swap = 1
      }
    }
  }
}

## remove/subtract characters in s2 from s1
function segsub(s1, s2) {
  gsub("["s2"]", "", s1)
  return s1
}

## decode output strings based on input strings
function decode(input, output,    s, num) {
  # sort input values alphabetically and by length
  astrsort(input)
  alensort(input)

  # substract segments of "one" from "seven" to get segment "a"
  s["a"] = segsub(input[2], input[1])

  # four - one = "b" + "d"
  bd = segsub(input[3], input[1])

  # three ("b", "d", "g")
  for (i=4; i<=6; i++) {
    # three - seven = "d" + "g"
    dg = segsub(input[i], input[2])

    if (length(dg) == 2) {
      s["g"] = segsub(dg, bd)
      s["d"] = segsub(dg, s["g"])
      s["b"] = segsub(bd, s["d"])
      three = i
      break
    }
  }

  # five ("c", "f")
  for (i=4; i<=6; i++) {
    # five - "a" - "b" - "d" - "g" = "f"
    # one - "f" = "c"
    tmp = segsub(input[i], s["a"] s["b"] dg)
    if (length(tmp) == 1) {
      s["f"] = tmp
      s["c"] = segsub(input[1], s["f"])
      five = i
      break
    }
  }

  # two ("e")
  for (i=4; i<=6; i++)
    if ((i != three) && (i != five))
      # "two" - "three" = "e"
      s["e"] = segsub(input[i], input[three])

  # decode to original segments
  segm[s["a"]] = "a"
  segm[s["b"]] = "b"
  segm[s["c"]] = "c"
  segm[s["d"]] = "d"
  segm[s["e"]] = "e"
  segm[s["f"]] = "f"
  segm[s["g"]] = "g"

  # decode output digits
  for (i=1; i<=length(output); i++) {
    digit = ""
    l = split(output[i], str, "")
    for (j=1; j<=l; j++)
      digit = digit segm[str[j]]

    num = num number[strsort(digit)]
  }

  return num
}


BEGIN {
  FS = "|"

  # original segmented number values
  number["abcefg"]  = 0
  number["cf"]      = 1
  number["acdeg"]   = 2
  number["acdfg"]   = 3
  number["bcdf"]    = 4
  number["abdfg"]   = 5
  number["abdefg"]  = 6
  number["acf"]     = 7
  number["abcdefg"] = 8
  number["abcdfg"]  = 9
}

{
  # split input and output into arrays
  split($1, input, " ")
  split($2, output, " ")

  # decode each output number and add to answer
  answer += decode(input, output)
}

END {
  print answer
}
