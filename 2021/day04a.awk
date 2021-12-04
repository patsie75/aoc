#!/usr/bin/gawk -f

## return the sum of all unmarked numbers
function unmarkedsum(card,    i, j, sum) {
  for (j=1; j<=5; j++)
    for (i=1; i<=5; i++)
      sum += card[j][i]
  return sum
}

## scratch a number of a card
function scratch(card, number,   i, j) {
  for (j=1; j<=5; j++)
    for (i=1; i<=5; i++)
      if (card[j][i] == number)
        card[j][i] = 0
}

## check for bingo
function bingo(card,    i, j, row, col) {
  for (j=1; j<=5; j++) {
    row = col = 0

    for (i=1; i<=5; i++) {
      if ( !card[j][i] ) row++
      if ( !card[i][j] ) col++
    }

    if ((row == 5) || (col == 5))
      return 1
  }
}


## first row are the picked numbers
(NR == 1) {
  numbers = split($1, number, ",")
}

## cards are separated by empty line
(NR > 1) && !NF {
  cards++
  row = 0
}

## card data
(NR > 1) && NF { 
  row++
  for (col=1; col<=5; col++)
    card[cards][row][col] = $col
}

END {
  # loop over all drawn numbers
  for (draw=1; draw<=numbers; draw++) {

    # process each bingo card
    for (cardnr=1; cardnr<=cards; cardnr++) {

      # scratch off the drawn number of the card
      scratch(card[cardnr], number[draw])

      # check for bingo
      if ( bingo(card[cardnr]) ) {
        #printf("draw: %d, cardnr: %d, sum: %d, num: %d, answer: %d\n", draw, cardnr, unmarkedsum(card[cardnr]), number[draw], unmarkedsum(card[cardnr]) * number[draw])
        printf("%d\n", unmarkedsum(card[cardnr]) * number[draw])
        exit
      }
    }
  }
}
