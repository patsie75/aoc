#!/usr/bin/mawk -f

function printmap(map,    x,y) {
  for (y=0; y<=height; y++) {
    for (x=0; x<=width; x++)
      printf("%c", map[x,y] ? "#" : ".")
    printf("\n")
  }
}

function yfold(map, linenr,    x,y) {
  height = linenr * 2

  for (y=linenr; y<=height; y++)
    for (x=0; x<=width; x++)
      map[x,(height-y)] = (map[x,y] || map[x,(height-y)]) ? 1 : 0
  height = (linenr - 1)
}

function xfold(map, colnr,    x,y) {
  width = colnr * 2

  for (x=colnr; x<=width; x++)
    for (y=0; y<=height; y++)
      map[(width-x),y] = (map[x,y] || map[(width-x),y]) ? 1 : 0
  width = (colnr - 1)
}


BEGIN { FS="," }

/^[0-9]*,[0-9]*$/ {
  map[$1,$2] = 1

  width  = ($1 > width)  ? $1 : width
  height = ($2 > height) ? $2 : height
}

/fold along x=[0-9]*/ {
  split($0, val, "=")
  xfold(map, val[2])
}

/fold along y=[0-9]*/ {
  split($0, val, "=")
  yfold(map, val[2])
}

END {
  printmap(map)
}
