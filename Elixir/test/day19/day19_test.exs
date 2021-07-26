defmodule Aoc2016Test.Day19Test do
  use ExUnit.Case

  # import Aoc2016.Day19

  doctest Aoc2016.Day19

  # @test_input """  """

  test "Day19 Test1" do
    assert Aoc2016.Day19.solution1("5") == 3
  end

  test "Day19 Test2" do
    assert Aoc2016.Day19.solution2("5") == 2
  end
end
