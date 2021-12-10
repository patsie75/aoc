#!/usr/bin/awk -f

function push(stack, elem) {
  stack[ stack["sp"]++ ] = elem
}

function pop(stack) {
  return stack[ --stack["sp"] ]
}

BEGIN {
  score[")"] = 3
  score["]"] = 57
  score["}"] = 1197
  score[">"] = 25137

  check["("] = ")"
  check["{"] = "}"
  check["["] = "]"
  check["<"] = ">"
}

{
  # split elements to array
  elems = split($0, elem, "")

  # loop over elements
  for (i=1; i<=elems; i++)
    if (elem[i] in check)
      # push opening brackets
      push(stack, elem[i])
    else {
      # pop and check closing brackets
      e = pop(stack)
      if (elem[i] != check[e]) {
        printf("line %3d elem %3d, expected %c, found %c, score + %5d = %8d\n", NR, i, check[e], elem[i], score[elem[i]], answer)
        answer += score[elem[i]]
        next
      }
    }
}

END {
  printf("%d\n", answer)
}
