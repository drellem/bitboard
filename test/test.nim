import os

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

# Test basic functionality

assert bitboard1.get(64) == true
assert bitboard1.get(65) == true
assert bitboard2.get(64) == false
assert bitboard2.get(65) == true


# Example non-trivial use case
# Consider an 8x8 array in the board.
# We write a radius-k function that gets
# all squares exactly k steps away

proc min(i : int, j : int) : int =
  # returns the smallest
  return (if i < j: i else: j)

proc max(i : int, j : int) : int =
  # returns the largest
  return (if i < j: j else: i)

proc withinBounds(row : int, col : int) : bool =
  # Verifies that the cell is within the bounds
  # of the matrix
  return 0 <= min(row, col) and 8 > max(row, col)

  
proc getCell(b : ptr Board, row : int, col : int) : bool =
  assert withinBounds(row, col)
  return b.get(row*8+col)

proc setCell(b : ptr Board, row : int, col : int, val : bool) =
  assert withinBounds(row, col)
  b.set(row*8+col, val)

proc radius(b : ptr Board, row : int, col : int, k : int) =
  for i in -1..1:
    for j in -1..1:
      if withinBounds(row+k*i, col+k*j):
        b.setCell(row+k*i, col+k*j, true)
  # Clear the center cell
  b.setCell(row, col, false)

proc countCells(b : ptr Board) : int =
  var count = 0
  for i in 0..7:
    for j in 0..7:
      if b.getCell(i, j):
        count = count + 1
  return count

proc printGrid(b : ptr Board)  =
  for i in 0..7:
    for j in 0..7:
      stdout.write(if b.getCell(i, j): 1 else: 0, " ")
    stdout.writeLine("")


bitboard1.zero()

bitboard1.radius(3, 6, 1)
echo "Radius 1"
bitboard1.printGrid()
assert bitboard1.countCells() == 8

bitboard1.zero()
bitboard1.radius(3, 6, 2)
echo "Radius 2"
bitboard1.printGrid()
assert bitboard1.countCells() == 5

# Free the memory

dealloc(bitboard1)
dealloc(bitboard2)

echo "Test complete"
