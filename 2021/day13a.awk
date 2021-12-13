#!/usr/bin/awk -f

function printmap(map,    x,y) {
  for (y=0; y<=height; y++) {
    for (x=0; x<=width; x++)
      printf("%c", map[x,y] ? "#" : ".")
    printf("\n")
  }
}

function yfold(map, linenr,    x,y) {
  height = linenr * 2

  for (y=0; y<linenr; y++)
    for (x=0; x<=width; x++)
      map[x,y] = (map[x,y] || map[x,(height-y)])
  height = (linenr - 1)
}

function xfold(map, colnr,    x,y) {
  width = colnr * 2

  for (y=0; y<=height; y++)
    for (x=0; x<=colnr; x++)
      map[x,y] = (map[x,y] || map[(width-x),y]) 
  width = (colnr - 1)
}


BEGIN { FS="[ ,=]" }

/^[0-9]*,[0-9]*$/ {
  map[$1,$2] = 1

  width  = ($1 > width)  ? $1 : width
  height = ($2 > height) ? $2 : height
}

/fold along x=[0-9]*/ {
  xfold(map, $4)
  exit
}

/fold along y=[0-9]*/ {
  yfold(map, $4)
  exit
}

END {
  for (y=0; y<=height; y++)
    for (x=0; x<=width; x++)
      answer += map[x,y]

  print answer
}
