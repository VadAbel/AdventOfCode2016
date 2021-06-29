defmodule Aoc2016.Day06 do
  @day "06"
  @input_file "../inputs/day#{@day}.txt"

  def select_freq(received, order) do
    Tuple.to_list(received)
    |> Enum.frequencies()
    |> Enum.sort_by(fn {_, x} -> x end, order)
    |> List.first()
    |> elem(0)
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&select_freq(&1, :desc))
    |> List.to_string()
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&select_freq(&1, :asc))
    |> List.to_string()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  "tzstqsua"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  "myregdnr"
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
