defmodule Aoc2016Test.Day21Test do
  use ExUnit.Case

  # import Aoc2016.Day21

  doctest Aoc2016.Day21

  @test_input """
  swap position 4 with position 0
  swap letter d with letter b
  reverse positions 0 through 4
  rotate left 1 step
  move position 1 to position 4
  move position 3 to position 0
  rotate based on position of letter b
  rotate based on position of letter d
  """

  test "Day21 Test1" do
    assert Aoc2016.Day21.solution1(@test_input, ?a..?e) == "decab"
  end

  test "Day21 Test2" do
    # assert Aoc2016.Day21.solution2("5") == 2
  end
end
