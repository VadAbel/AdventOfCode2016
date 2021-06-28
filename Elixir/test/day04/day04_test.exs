defmodule Aoc2016Test.Day04Test do
  use ExUnit.Case
  doctest Aoc2016.Day04

  test "Day04 Test1" do
    assert Aoc2016.Day04.solution1("aaaaa-bbb-z-y-x-123[abxyz]\na-b-c-d-e-f-g-h-987[abcde]\nnot-a-real-room-404[oarel]\ntotally-real-room-200[decoy]") == 1514
  end

  test "Day04 Test2" do
    # assert Aoc2016.Day04.solution2() == ?
  end
end
