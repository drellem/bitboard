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

type Board = array[WORD_LEN, uint]

proc newBitboard*() : ptr Board =
  # Allocates a a new Bitboard.
  return cast[ptr Board](alloc0(sizeof(Board)))

proc zero*(b : ptr Board) =
  # Zeroes out a bitboard
  for i in 0..WORD_LEN-1:
    b[i] = 0
  
proc get*(b :  ptr Board, i : int ) : bool  =
  # gets the ith value from the bitboard
  if(i < 0 or i >= BIT_LEN):
    raise newException(IndexDefect, "Invalid index " & $i)
  var word = i div INT_SZ
  var bit = i mod INT_SZ
  return b[word].testBit(bit)

proc set*(b : ptr Board, i : int, val : bool ) : void =
  # Sets the ith value of the bitboard
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

proc bbOr*(b : ptr Board, b2 : ptr Board) =
  # Takes the union of the two bitboards and stores in the first
  for i in 0..WORD_LEN-1:
    b[i] = b[i] or b2[i]

proc bbAnd*(b : ptr Board, b2 : ptr Board) =
  # Takes the intersection of the two bitboards and stores in the first
  for i in 0..WORD_LEN-1:
    b[i] = b[i] and b2[i]

  
