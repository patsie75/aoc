#!/usr/bin/awk -f

function min(a, b) { return (a < b) ? a : b }
function max(a, b) { return (a > b) ? a : b }

function coordinate(p1, p2, coord,    a) {
  if (split(p1, a, ",") == 2) {
    coord["x1"] = a[1]
    coord["y1"] = a[2]
  }
  if (split(p2, a, ",") == 2) {
    coord["x2"] = a[1]
    coord["y2"] = a[2]
  }
}

{
  # convert data to a coordinate
  coordinate($1, $3, c)

  # calculate max map with and height
  width  = max(c["x1"], max(c["x2"], width) )
  height = max(c["y1"], max(c["y2"], height) )

  # plot horizontal map coordinates
  if (c["x1"] == c["x2"]) {
    x = c["x1"]
    y1 = min(c["y1"], c["y2"])
    y2 = max(c["y1"], c["y2"])

    for (y=y1; y<=y2; y++)
      map[y,x]++
  }

  # plot vertical map coordinates
  if (c["y1"] == c["y2"]) {
    y = c["y1"]
    x1 = min(c["x1"], c["x2"])
    x2 = max(c["x1"], c["x2"])

    for (x=x1; x<=x2; x++)
      map[y,x]++
  }
}

END {
  # count all map coordinates 2 or more
  for (y=0; y<=height; y++)
    for (x=0; x<=width; x++)
      if (map[y,x] >= 2) answer++

  print answer
}
