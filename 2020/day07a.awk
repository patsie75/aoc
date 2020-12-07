#!/usr/bin/awk -f

function recurse(rule, check,    bags, bag, b, count) {
  split(rules[rule], bags, "|")

  for (bag in bags) {
    ## only need the bag name, not the number
    b = substr(bags[bag], 3)

    ## bag is found
    if (b == check) return(1)

    ## continue search
    count += recurse(b, check)
  }

  return(count)
}

BEGIN { FS=", " }

## reorganize/sanatize input
sub(/ bags contain /, ", ") { }
gsub(/\.$| bags?/, "") { }

## bag with no content
/no other/ { rules[$1] = ""; next }

## parse rules
{ 
  rules[$1] = $2
  for (i=3; i<=NF; i++)
    rules[$1] = rules[$1] "|" $i
}

## give answer
END {
  for (rule in rules)
    if (recurse(rule, "shiny gold"))
      answer++

  printf("answer: %d\n", answer)
}
