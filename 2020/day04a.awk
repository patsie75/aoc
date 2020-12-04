#!/usr/bin/awk -f

BEGIN {
  ## records separated by empty newline
  RS="\n\n"

  # define mandatory records
  mandatory["byr"] = 1
  mandatory["iyr"] = 1
  mandatory["eyr"] = 1
  mandatory["hgt"] = 1
  mandatory["hcl"] = 1
  mandatory["ecl"] = 1
  mandatory["pid"] = 1
}

{
  ## delete previous record data
  delete record

  ## fill record data "key:value"
  for (i=1; i<=NF; i++) {
    split($i, keyval, ":")
    record[keyval[1]] = keyval[2]
  }

  ## if mandatory record is missing, skip to next record
  for (key in mandatory) {
    if (! (key in record) )
      next
  }

  valid++
}

END {
  # print result
  printf("valid records: %s\n", valid)
}

