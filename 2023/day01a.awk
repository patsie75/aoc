#!/bin/awk -f

{
  gsub(/[^0-9]/, "")		# remove any non-numeric character
  n = split($0, arr, "")	# split digits to array
  val = arr[1] "" arr[n]	# get first and last digit
  sum += val			# add to sum
}

END {
  print sum
}
