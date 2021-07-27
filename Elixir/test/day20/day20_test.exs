defmodule Aoc2016Test.Day20Test do
  use ExUnit.Case

  # import Aoc2016.Day20

  doctest Aoc2016.Day20

  @test_input """
  5-8
  0-2
  4-7
  """

  test "Day20 Test1" do
    assert Aoc2016.Day20.solution1(@test_input) == 3
  end

  test "Day20 Test2" do
    # assert Aoc2016.Day20.solution2("5") == 2
  end
end
