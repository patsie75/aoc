#!/usr/bin/awk -f

(NR == 1) { depth = $1 }

(NR > 1) {
  if ($1 > depth) { increased++ }
  depth = $1
}

END { printf("%d\n", increased) }
