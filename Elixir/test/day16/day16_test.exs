defmodule Aoc2016Test.Day16Test do
  use ExUnit.Case

  # import Aoc2016.Day16

  doctest Aoc2016.Day16

  # @test_input """  """

  test "Day16 Test1" do
    assert Aoc2016.Day16.solution1("10000", 20) == "01100"
  end

  test "Day16 Test2" do
    # assert Aoc2016.Day16.solution2(@test_input) == 22551
  end
end
