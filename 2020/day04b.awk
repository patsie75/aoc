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

  ## define valid eye colors
  eyecolors["amb"] = 1
  eyecolors["blu"] = 1
  eyecolors["brn"] = 1
  eyecolors["gry"] = 1
  eyecolors["grn"] = 1
  eyecolors["hzl"] = 1
  eyecolors["oth"] = 1
}

{
  ## delete previous record data
  delete record

  ## fill record data "key:value"
  for (i=1; i<=NF; i++) {
    split($i, keyval, ":")
    record[keyval[1]] = keyval[2]
  }

  printf("\n")

  ## check all mandatory data
  for (key in mandatory) {

    ## mandatory data is missing
    if (! (key in record) ) {
      printf("Missing mandatory key \"%s\"\n", key)
      next
    }

    ## print record data for debugging
    printf("record[% 3s] = % 10s ", key, record[key])

    ## check birth year (1920-2002)
    if (key == "byr") {
      if ( (record[key] < 1920) || (record[key] > 2002) ) {
        print "(not between 1920 and 2002)"
        next
      }
      print "(ok)"
    }

    ## check issue year (2010-2020)
    if (key == "iyr") {
      if ( (record[key] < 2010) || (record[key] > 2020) ) {
        print "(not between 2010 and 2020)"
        next
      }
      print "(ok)"
    }

    ## check expiration year (2020-2030)
    if (key == "eyr") {
      if ( (record[key] < 2020) || (record[key] > 2030) ) {
        print "(not between 2020 and 2030)"
        next
      }
      print "(ok)"
    }

    ## check height
    if (key == "hgt") {
      ## get value + unit of measurement from record
      value = substr(record[key], 1, length(record[key])-2)
      units = substr(record[key], length(record[key])-1, 2)

      ## check unit of measurement
      if ((units != "cm") && (units != "in")) {
        print "(invalid units)"
        next
      }

      ## check height in cm (150-193)
      if ( (units == "cm") && ((value < 150) || (value > 193)) ) {
        print "(not between 150cm and 193cm)"
        next
      }

      ## check height in inch (59-76
      if ( (units == "in") && ((value < 59) || (value > 76)) ) {
        print "(not between 59in and 76in)"
        next
      }

      print "(ok)"
    }

    ## check hair color (#[0-9a-f]{6})
    if (key == "hcl") {
      if (! (record[key] ~ /^#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$/)) {
        print "(invalid haircolor)"
        next
      }
      print "(ok)"
    }

    ## check eye color (fixed list)
    if (key == "ecl") {
      if (! (record[key] in eyecolors) ) {
        print "(invalid eyecolor)"
        next
      }
      print "(ok)"
    }

    ## check passport ID (9 digits)
    if (key == "pid") {
      if (! (record[key] ~ /^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$/) ) {
        print "(not 9 numbers)"
        next
      }
      print "(ok)"
    }

  }

  valid++
}

END {
  ## print result
  printf("\nnumber of valid passports: %d\n", valid)
}

