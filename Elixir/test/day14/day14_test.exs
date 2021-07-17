defmodule Aoc2016Test.Day14Test do
  use ExUnit.Case

  # import Aoc2016.Day14

  doctest Aoc2016.Day14

  test "Day14 Test1" do
    assert Aoc2016.Day14.solution1("abc") == 22728
  end

  test "Day14 Test2" do
    assert Aoc2016.Day14.solution2("abc") == 22551
  end
end
