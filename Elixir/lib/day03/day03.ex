defmodule Aoc2016.Day03 do
  @day "03"
  @input_file "../inputs/day#{@day}.txt"

  def parse(dimensions) do
    dimensions
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  def is_valid_triangle?(dimensions) do
    [x, y, z] = Enum.sort(dimensions)
    z < x + y
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.count(&is_valid_triangle?/1)
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.chunk_every(3)
    |> Enum.flat_map(&List.zip/1)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.count(&is_valid_triangle?/1)
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  983
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  1836
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
