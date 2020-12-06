#!/usr/bin/awk -f

BEGIN { RS="" }

{
  ## clear previous yes-answers
  delete yes

  ## loop over all fields in a group
  for (i=1; i<=NF; i++) {

    ## loop over all yes-answers
    split($i, answers, "")
    for (ans in answers)
      yes[answers[ans]] = 1
  }

  ## add yes-answers to total
  total += length(yes)
}

END {
  ## print result
  printf("total yes-answer: %d\n", total)
}
