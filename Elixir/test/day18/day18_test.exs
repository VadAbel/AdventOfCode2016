defmodule Aoc2016Test.Day18Test do
  use ExUnit.Case

  # import Aoc2016.Day18

  doctest Aoc2016.Day18

  # @test_input """  """

  test "Day18 Test1" do
    assert Aoc2016.Day18.solution1(".^^.^.^^^^", 10) == 38
  end

  test "Day18 Test2" do
    # assert Aoc2016.Day18.solution2("ihgpwlah") == 370
  end
end
