#!/usr/bin/awk -f

$1 == "forward" { forward += $2 }
$1 == "down" { depth += $2 }
$1 == "up" { depth -= $2 }

END { printf("%d\n", forward * depth) }
