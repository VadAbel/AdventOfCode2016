defmodule Aoc2016Test.Day01Test do
  use ExUnit.Case
  doctest Aoc2016.Day01

  test "Day01 Test1" do
    assert Aoc2016.Day01.solution1("R2, L3") == 5
    assert Aoc2016.Day01.solution1("R2, R2, R2") == 2
    assert Aoc2016.Day01.solution1("R5, L5, R5, R3") == 12
  end

  test "Day01 Test2" do
    assert Aoc2016.Day01.solution2("R8, R4, R4, R8") == 4
  end
end
