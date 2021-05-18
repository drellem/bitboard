# Tests bitboard.nim

import bitboard

var bb : array[WORD_LEN, uint]
var bb2 : array[WORD_LEN, uint]

var bitboard1 = addr(bb)
var bitboard2 = addr(bb2)

# initialize

for i in 0..WORD_LEN-1:
  bitboard1[i] = 0
  bitboard2[i] = 0

bitboard1.set(64, true)
bitboard2.set(65, true)

bb = bitboard1.bbOr(bitboard2)
bb2 = bitboard1.bbAnd(bitboard2)

assert bitboard1.get(64) == true
assert bitboard1.get(65) == true
assert bitboard2.get(64) == false
assert bitboard2.get(65) == true

echo "Test complete"
