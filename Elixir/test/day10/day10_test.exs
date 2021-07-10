defmodule Aoc2016Test.Day10Test do
  use ExUnit.Case

  import Aoc2016.Day10

  doctest Aoc2016.Day10

  @test_input "value 5 goes to bot 2\n  bot 2 gives low to bot 1 and high to bot 0\n  value 3 goes to bot 1\n  bot 1 gives low to output 1 and high to bot 0\n  bot 0 gives low to output 2 and high to output 0\n  value 2 goes to bot 2"

  test "Day10 - parse" do
    # input = "value 5 goes to bot 2\nbot 2 gives low to bot 1 and high to bot 0\nvalue 3 goes to bot 1\nbot 1 gives low to output 1 and high to bot 0\nbot 0 gives low to output 2 and high to output 0\nvalue 2 goes to bot 2"
    assert parse_line("value 5 goes to bot 2") ==
             {:input,
              %{
                2 => %{value: MapSet.new([5])}
              }}

    assert parse_line("bot 2 gives low to bot 1 and high to bot 0") ==
             {:bot,
              %{
                2 => %{low: {:bot, 1}, high: {:bot, 0}}
              }}

    assert parse_line("bot 1 gives low to output 1 and high to bot 0") ==
             {:bot,
              %{
                1 => %{low: {:output, 1}, high: {:bot, 0}}
              }}

    assert String.split(@test_input, "\n", trim: true) |> parse() ==
             %{
               input: %{
                 1 => %{value: MapSet.new([3])},
                 2 => %{value: MapSet.new([2, 5])}
               },
               bot: %{
                 0 => %{
                   low: {:output, 2},
                   high: {:output, 0}
                 },
                 1 => %{
                   low: {:output, 1},
                   high: {:bot, 0}
                 },
                 2 => %{
                   low: {:bot, 1},
                   high: {:bot, 0}
                 }
               },
               output: %{}
             }
  end

  test "Day10 Test1" do
    assert String.split(@test_input, "\n", trim: true) |> parse() |> process ==
             %{
               input: %{
                 1 => %{value: MapSet.new([3])},
                 2 => %{value: MapSet.new([2, 5])}
               },
               bot: %{
                 0 => %{
                   low: {:output, 2},
                   high: {:output, 0},
                   value: MapSet.new([5, 3])
                 },
                 1 => %{
                   low: {:output, 1},
                   high: {:bot, 0},
                   value: MapSet.new([3, 2])
                 },
                 2 => %{
                   low: {:bot, 1},
                   high: {:bot, 0},
                   value: MapSet.new([2, 5])
                 }
               },
               output: %{
                 0 => %{value: MapSet.new([5])},
                 1 => %{value: MapSet.new([2])},
                 2 => %{value: MapSet.new([3])}
               }
             }

    #  assert Aoc2016.Day10.solution1(input) ==
  end

  test "Day10 Test2" do
    # assert Aoc2016.Day10.solution2() == true
  end
end
