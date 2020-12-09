#!/usr/bin/awk -f

## run code
function run(code,     size, acc, ip, visited, instr) {
  size = length(code)
  acc = 0
  ip = 0

  ## run until end of instructions
  while (ip < size) {

    ## set current instruction pointer as visited
    visited[ip] = 1

    ## split instruction and argument then increase IP
    split(code[ip], instr, " ")

    ## "acc" increases accumulator
    if (instr[1] == "acc")
      acc += instr[2]

    ## "jmp" jumps relative from instruction pointer
    if (instr[1] == "jmp") {
      ## return -1 if next instruction was already run before
      if ((ip + instr[2]) in visited)
        return(-1)

      ip += instr[2]
      continue
    }

    ## increase instruction pointer (next instruction)
    ip++
  }

  ## return accumulator content
  return(acc)
}

{
  ## read code
  code[n++] = $0
}

END {
  ## brute force approach
  ## change each subsequent JMP to NOP

  for (i=0; i<n; i++) {
    ## change next "jmp" instruction to "nop"
    if (code[i] ~ /^jmp /) {
      org = code[i]
      sub(/^jmp /, "nop ", code[i])

      ## run code
      answer = run(code)

      if (answer != -1) {
        ## found the answer
        printf("answer: %d (changed ip @%d from \"%s\" to \"%s\")\n", answer, i, org, code[i])
        exit 0
      } else {
        ## return code to original state
        code[i] = org
      }
    }

  }
}
