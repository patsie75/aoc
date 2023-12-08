#!/usr/bin/gawk -f

BEGIN {
  FS = "[:;]"		# separate fields on colun of semi-colon
}

{
  max["red"] = max["green"] = max["blue"] = 0

  for (i=2; i<=NF; i++) {	# loop over remaining fields
    n = split($i, arr, ",")	# split set of values
    for (j=1; j<=n; j++) {
      split(arr[j], arr2, " ")	# get color and value

      if (arr2[1] > max[arr2[2]]) # find biggest color value,
        max[arr2[2]] = arr2[1]
    }
  }

  # multiply all colour values
  power = max["red"] * max["green"] * max["blue"]

  answer += power		# sum all power values
}

END {
  print answer			# print result
}
