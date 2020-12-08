#!/usr/bin/awk -f

function run(code,    acc, ip, visited, instr) {
  acc = 0
  ip = 0

  ## run until code repeats
  while (! (ip in visited)) {
    ## set current instruction pointer as visited
    visited[ip] = 1

    ## split instruction and argument then increase IP
    split(code[ip++], instr, " ")

    ## "acc" increases accumulator
    if (instr[1] == "acc")
      acc += instr[2]

    ## "jmp" jumps relative from instruction pointer
    if (instr[1] == "jmp")
      ip += (instr[2] - 1)
  }

  ## return accumulator content
  return(acc)
}

{
  ## read code
  code[n++] = $0
}

END {
  ## run code and print result
  printf("Answer: %d\n", run(code))
}
