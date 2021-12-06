#!/usr/bin/awk -f

{ fishes = split($0, fish, ",") }

END {
  for (day=1; day<=80; day++) {
    for (i=1; i<=fishes; i++) {
      if (fish[i]) fish[i]--
      else {
        fish[i] = 6
        fish[++fishes] = 9
      }
    }
  }

  printf("%d\n", fishes)
}
