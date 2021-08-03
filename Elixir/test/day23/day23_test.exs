defmodule Aoc2016Test.Day23Test do
  use ExUnit.Case

  # import Aoc2016.Day23

  doctest Aoc2016.Day23

  @test_input """
  cpy 2 a
  tgl a
  tgl a
  tgl a
  cpy 1 a
  dec a
  dec a
  """
  test "Day23 Test1" do
    assert Aoc2016.Day23.solution1(@test_input) == 3
  end

  test "Day23 Test2" do
    # assert Aoc2016.Day23.solution2() == true
  end
end
