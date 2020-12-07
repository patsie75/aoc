#!/usr/bin/awk -f

function recurse(multiplier, find,    bags, bag, b, cnt) {
  ## no more nesting, return
  if (rules[find] == "")
    return multiplier

  ## get bag content
  split(rules[find], bags, "|")

  ## loop over all bags
  for (b in bags) {
    cnt = substr(bags[b], 1, 1)
    bag = substr(bags[b], 3)

    # add this bag to the total sum
    sum += (multiplier * cnt)

    # recurse into bag
    recurse(multiplier * cnt, bag)
  }

  ## return total sum
  return(sum)
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
  printf("answer: %d\n", recurse(1, "shiny gold"))
}
