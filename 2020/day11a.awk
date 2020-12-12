#!/usr/bin/awk -f

function isOccupied(cell, neighbour) {
  ## check if we are off screen or wrapped around
  if ( (neighbour < 1) || (neighbour > (width*height)) ) return 0
  if ( ((cell%width) == 1) && ((neighbour%width) == 0) ) return 0
  if ( ((cell%width) == 0) && ((neighbour%width) == 1) ) return 0

  return (substr(data, neighbour, 1) == OCCUP) ? 1 : 0;
}

function countOccupied(cell,   cnt) {
  cnt  = isOccupied(cell, cell-width-1) + isOccupied(cell, cell-width) + isOccupied(cell, cell-width+1);
  cnt += isOccupied(cell, cell-1) + isOccupied(cell, cell+1);
  cnt += isOccupied(cell, cell+width-1) + isOccupied(cell, cell+width) + isOccupied(cell, cell+width+1);
  return cnt;
}

# display playfield
function display(field,   i) {
  for (i=0; i<NR; i++)
    printf("%s\n", substr(field, i*width+1, width));
}

{
  ## read all data
  data = data $0
}

END {
  EMPTY = "L"
  OCCUP = "#"
  FLOOR = "."

  ## get total size, plus width and height of field
  size   = length(data)
  height = NR
  width  = int(size / height)

  ## make sure our input data is correct
  if (width != (size / height)) exit 1

  changes = 1 
  while (changes) {
    printf("\rstep: %03d", ++step)

    newdata = ""
    for (cell=1; cell<=size; cell++) {
      ## get current state of cell
      newstate = oldstate = substr(data, cell, 1)

      if (oldstate != FLOOR) {
        cnt = countOccupied(cell)
        if (cnt == 0) newstate = OCCUP
        if (cnt > 3)  newstate = EMPTY
      }

      ## add newstate to our new data
      newdata = newdata newstate;
    }

    ## check for any changes between our current and new states
    if (newdata == data)
      changes = 0
    data = newdata
  }

  ## display end result and answer
  display(data)

  for (cell=1; cell<=size; cell++)
    answer += (substr(data, cell, 1) == OCCUP)

  printf("\nAnswer: %d\n", answer)
}
