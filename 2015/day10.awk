#!/usr/bin/awk -f

function lookandsay(str,    result, n, i, j, arr, cnt) {
  # split input into individual characters
  n = split(str, arr, "")

  # get first character and start counting at 1
  j = arr[1]
  cnt = 1

  # loop over remaining characters
  for (i=2; i<=n; i++) {
    # if same number, then increase counter
    if (arr[i] == j)
      cnt++
    else {
      # not the same number, add counter plus charachter and start over
      result = result cnt j
      j = arr[i]
      cnt = 1
    }
  }

  # return the result, plus the remaining characters
  return(result cnt j)
}


## do not forget to add a (for example) "-v loops=40" to the awk program
{
  for (i=0; i<loops; i++)
    $1 = lookandsay($1)

  print length($1)
}

