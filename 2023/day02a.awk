#!/usr/bin/gawk -f

BEGIN {
  FS = "[:;]"		# separate fields on colun of semi-colon

  max["red"]   = 12	# the max number of red
  max["green"] = 13	# the max numnber of green
  max["blue"]  = 14	# the max number of blue
}

{
  split($1, arr, " ")		# Get game number
  gamenr = arr[2]

  for (i=2; i<=NF; i++) {	# loop over remaining fields
    n = split($i, arr, ",")	# split set of values
    for (j=1; j<=n; j++) {
      split(arr[j], arr2, " ")	# get color and value

      if (arr2[1] > max[arr2[2]]) # if value is out of bounds,
        next			# skip to next entry
    }
  }

  answer += gamenr		# sum all game numbers
}

END {
  print answer			# print result
}
