defmodule Aoc2016Test.Day17Test do
  use ExUnit.Case

  # import Aoc2016.Day17

  doctest Aoc2016.Day17

  # @test_input """  """

  test "Day17 Test1" do
    assert Aoc2016.Day17.solution1("ihgpwlah") == "DDRRRD"
    assert Aoc2016.Day17.solution1("kglvqrro") == "DDUDRLRRUDRD"
    assert Aoc2016.Day17.solution1("ulqzkmiv") == "DRURDRUDDLLDLUURRDULRLDUUDDDRR"
  end

  test "Day17 Test2" do
    assert Aoc2016.Day17.solution2("ihgpwlah") == 370
    assert Aoc2016.Day17.solution2("kglvqrro") == 492
    assert Aoc2016.Day17.solution2("ulqzkmiv") == 830
  end
end
