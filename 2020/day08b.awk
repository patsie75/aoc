#!/usr/bin/awk -f

## copy src array to dst array
function copy(src, dst,    l, i) {
  l = length(src)

  delete dst
  for (i=0; i<l; i++)
    dst[i] = src[i]
}

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

  ## repeat for all instruction
  for (i=0; i<n; i++) {
    ## reset our code to original
    copy(code, runcode)

    ## modify next "jmp" instruction
    for (j=i; j<n; j++) {
      # change "jmp" to "nop"
      split(runcode[j], instr)
      if (instr[1] == "jmp") {
        runcode[j] = "nop " instr[2]
        break
      }
    }

    ## run our modified code
    answer = run(runcode)
    if (answer != -1) {
      printf("answer: %d (changed ip @%d from \"%s\" to \"%s\")\n", answer, j, code[j], runcode[j])
      exit 0
    }
  }
}
