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
      yes[answers[ans]]++
  }

  ## only add answers which have a count of all people in group (NF)
  for (i in yes)
    if (yes[i] == NF)
      total++
}

END {
  ## print result
  printf("total yes-answer: %d\n", total)
}
