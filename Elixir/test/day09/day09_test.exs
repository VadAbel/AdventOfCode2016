defmodule Aoc2016Test.Day09Test do
  use ExUnit.Case

  # import Aoc2016.Day09

  doctest Aoc2016.Day09

  test "Day09 Test1" do
    assert Aoc2016.Day09.solution1("ADVENT") == 6
    assert Aoc2016.Day09.solution1("A(1x5)BC") == 7
    assert Aoc2016.Day09.solution1("(3x3)XYZ") == 9
    assert Aoc2016.Day09.solution1("A(2x2)BCD(2x2)EFG") == 11
    assert Aoc2016.Day09.solution1("(6x1)(1x3)A") == 6
    assert Aoc2016.Day09.solution1("X(8x2)(3x3)ABCY") == 18
  end

  test "Day08 Test2" do
    assert Aoc2016.Day09.solution2("(3x3)XYZ") == String.length("XYZXYZXYZ")
    assert Aoc2016.Day09.solution2("X(8x2)(3x3)ABCY") == String.length("XABCABCABCABCABCABCY")
    assert Aoc2016.Day09.solution2("(27x12)(20x12)(13x14)(7x10)(1x12)A") == 241_920

    assert Aoc2016.Day09.solution2("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN") ==
             445
  end
end
