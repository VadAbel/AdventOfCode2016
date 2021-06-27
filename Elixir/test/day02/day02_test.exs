defmodule Aoc2016Test.Day02Test do
  use ExUnit.Case
  doctest Aoc2016.Day02

  test "Day02 Test1" do
    assert Aoc2016.Day02.solution1("ULL") == "1"
    assert Aoc2016.Day02.solution1("ULL\nRRDDD\nLURDL\nUUUUD") == "1985"
  end

  test "Day02 Test2" do
    assert Aoc2016.Day02.solution2("ULL") == "5"
    assert Aoc2016.Day02.solution2("ULL\nRRDDD\nLURDL\nUUUUD") == "5DB3"
  end
end
