#!/usr/bin/awk -f

$1 == "forward" { forward += $2; depth += (aim * $2) }
$1 == "down" { aim += $2 }
$1 == "up" { aim -= $2 }

END { printf("%d\n", forward * depth) }
