# Tests bitboard.nim

import bitboard

# Allocate new bitboards

var bitboard1 = newBitboard()
var bitboard2 = newBitboard()

# initialize

bitboard1.zero()
bitboard2.zero()

bitboard1.set(64, true)
bitboard2.set(65, true)

# Do some operations

bitboard1.bbOr(bitboard2)
bitboard2.bbAnd(bitboard1)

# Test

assert bitboard1.get(64) == true
assert bitboard1.get(65) == true
assert bitboard2.get(64) == false
assert bitboard2.get(65) == true

# Free the memory

dealloc(bitboard1)
dealloc(bitboard2)

echo "Test complete"
