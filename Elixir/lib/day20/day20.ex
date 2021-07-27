defmodule Aoc2016.Day20 do
  @day "20"
  @input_file "../inputs/day#{@day}.txt"

  def parse(row) do
    row
    |> String.split("-", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> then(fn [x, y] -> Range.new(x, y) end)
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.sort_by(&Enum.min/1, &<=/2)
    |> Enum.reduce_while(-1, fn x..y, z ->
      if x > z + 1,
        do: {:halt, z + 1},
        else: {:cont, max(y, z)}
    end)
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.sort_by(&Enum.min/1, &<=/2)
    |> Enum.reduce([], fn
      a..b, [] ->
        [a..b]

      a..b, [c..d | t] ->
        if a > d + 1,
          do: [a..b, c..d | t],
          else: [c..max(b, d) | t]
    end)
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
    |> then(&(Range.size(0..4_294_967_295) - &1))
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  23923783
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  125
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
