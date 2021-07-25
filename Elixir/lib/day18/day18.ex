defmodule Aoc2016.Day18 do
  @day "18"
  @input_file "../inputs/day#{@day}.txt"

  @safe ?.
  @trap ?^

  def next_row(previous) do
    Enum.chunk_every([@safe | previous], 3, 1, [@safe])
    |> Enum.map(fn
      [l, _, r] when l != r -> @trap
      _ -> @safe
    end)
  end

  def process(first_line, to_take) do
    first_line
    |> Stream.iterate(&next_row/1)
    |> Stream.map(&Enum.count(&1, fn x -> x == @safe end))
    |> Stream.take(to_take)
    |> Enum.sum()
  end

  def solution1(input, to_take \\ 40) do
    input
    |> String.to_charlist()
    |> process(to_take)
  end

  def solution2(input, to_take \\ 400_000) do
    input
    |> String.to_charlist()
    |> process(to_take)
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  2013
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  20006289
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
