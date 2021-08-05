defmodule Aoc2016Test.Day24Test do
  use ExUnit.Case

  # import Aoc2016.Day24

  doctest Aoc2016.Day24

  @test_input """
  ###########
  #0.1.....2#
  #.#######.#
  #4.......3#
  ###########
  """
  test "Day24 Test1" do
    assert Aoc2016.Day24.solution1(@test_input) == 14
  end

  test "Day24 Test2" do
    # assert Aoc2016.Day24.solution2() == true
  end
end
