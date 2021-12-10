#!/usr/bin/gawk -f

function push(stack, elem) {
  stack[ stack["sp"]++ ] = elem
}

function pop(stack) {
  return stack[ --stack["sp"] ]
}

BEGIN {
  score["("] = 1
  score["["] = 2
  score["{"] = 3
  score["<"] = 4

  check["("] = ")"
  check["{"] = "}"
  check["["] = "]"
  check["<"] = ">"
}

{
  # split elements to array
  elems = split($0, elem, "")
  delete stack

  # loop over elements
  for (i=1; i<=elems; i++) {
    if (elem[i] in check)
      # push opening brackets
      push(stack, elem[i])
    else {
      # pop and check closing brackets, skip corrupt lines
      e = pop(stack)
      if (elem[i] != check[e]) {
        #printf("line %03d: corrupt:   skipped\n", NR)
        next
      }
    }
  }

  # incomplete line, 
  answers++
  while (stack["sp"] > 0) {
    e = pop(stack)
    answer[answers] *= 5
    answer[answers] += score[e]
  }
  #printf("line %03d: score[%d]: %8d\n", NR, answers, answer[answers])
}

END {
  asort(answer)
  printf("%d\n", answer[int(answers/2)+1])
}
