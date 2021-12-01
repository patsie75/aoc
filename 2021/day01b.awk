#!/usr/bin/awk -f

(NR <= 3) { win[NR] = $1 }

(NR > 3) {
  if ( (win[2] + win[3] + $1) > (win[1] + win[2] + win[3]) ) { increased++ }

  win[1] = win[2]
  win[2] = win[3]
  win[3] = $1
}

END { printf("%d\n", increased) }
