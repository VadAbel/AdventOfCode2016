defmodule Aoc2016Test.Day15Test do
  use ExUnit.Case

  # import Aoc2016.Day15

  doctest Aoc2016.Day15

  @test_input """
  Disc #1 has 5 positions; at time=0, it is at position 4.
  Disc #2 has 2 positions; at time=0, it is at position 1.
  """

  test "Day15 Test1" do
    assert Aoc2016.Day15.solution1(@test_input) == 5
  end

  test "Day15 Test2" do
    # assert Aoc2016.Day15.solution2(@test_input) == 22551
  end
end
