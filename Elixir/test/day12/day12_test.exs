defmodule Aoc2016Test.Day12Test do
  use ExUnit.Case

  # import Aoc2016.Day12

  doctest Aoc2016.Day12

  @test_input """
  cpy 41 a
  inc a
  inc a
  dec a
  jnz a 2
  dec a
  """
  test "Day12 Test1" do
    assert Aoc2016.Day12.solution1(@test_input) == 42
  end

  test "Day12 Test2" do
    # assert Aoc2016.Day12.solution2() == true
  end
end
