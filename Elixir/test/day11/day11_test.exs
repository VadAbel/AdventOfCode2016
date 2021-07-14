defmodule Aoc2016Test.Day11Test do
  use ExUnit.Case

  import Aoc2016.Day11

  doctest Aoc2016.Day11

  @test_input """
  The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
  The second floor contains a hydrogen generator.
  The third floor contains a lithium generator.
  The fourth floor contains nothing relevant.
  """

  test "Day11 - Parse" do
    assert parse_line(
             "The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip."
           ) == %{1 => MapSet.new(microchip: "hydrogen", microchip: "lithium")}

    assert @test_input |> String.split("\n", trim: true) |> parse() ==
             {1,
              %{
                1 => MapSet.new(microchip: "hydrogen", microchip: "lithium"),
                2 => MapSet.new(generator: "hydrogen"),
                3 => MapSet.new(generator: "lithium"),
                4 => MapSet.new([])
              }}
  end

  test "Day11 Test1" do
    assert Aoc2016.Day11.solution1(@test_input) == 11
  end

  test "Day11 Test2" do
    # assert Aoc2016.Day11.solution2() == true
  end
end
