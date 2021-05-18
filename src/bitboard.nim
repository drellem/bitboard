################################################################################
##########                       bitboard.nim                         ##########
################################################################################
################################################################################
##########    Provides basic tools for creating and manipulating      ##########
##########    bitboards. A bitboard is an efficient array/matrix      ##########
##########    of bits used to implement efficient computations for    ##########
##########    board games. By default these have 256 entries.         ##########
################################################################################

import bitops

# Type alias for a BitBoard256
# typedef BitBoard256 = [0..7, uint]

const WORD_LEN* = 8 # size of bitboard is 2^BIT_LEN
const BIT_LEN* = 256 # todo import math and use "proc(2, WORD_LEN)"
const INT_SZ* = 32 # number of bits in an int


proc get*(b :  ptr array[WORD_LEN, uint], i : int ) : bool  =
  # gets the kth value from the bitboard
  if(i < 0 or i >= BIT_LEN):
    raise newException(IndexDefect, "Invalid index " & $i)
  var word = i div INT_SZ
  var bit = i mod INT_SZ
  return b[word].testBit(bit)

proc set*(b : ptr array[WORD_LEN, uint], i : int, val : bool ) : void =
  if(i < 0 or i >= BIT_LEN):
    raise newException(IndexDefect, "Invalid var i = " & $i)
  var word = i div INT_SZ
  var bit = i mod INT_SZ
  var wordVal = b[word]
  if(val):
    wordVal.setBit(bit)
  else:
    wordVal.clearBit(bit)
  b[word] = wordVal

proc bbOr*(b : ptr array[WORD_LEN, uint], b2 : ptr array[WORD_LEN, uint]): array[WORD_LEN, uint] =
    var ret : array[WORD_LEN, uint]
    for i in 0..WORD_LEN-1:
      ret[i] = b[i] or b2[i]
    return ret

proc bbAnd*(b : ptr array[WORD_LEN, uint], b2 : ptr array[WORD_LEN, uint]): array[WORD_LEN, uint] =
    var ret : array[WORD_LEN, uint]
    for i in 0..WORD_LEN-1:
      ret[i] = b[i] and b2[i]
    return ret

  
