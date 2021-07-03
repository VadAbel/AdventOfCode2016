defmodule Aoc2016.Day09 do
  @day "09"
  @input_file "../inputs/day#{@day}.txt"

  def parse("", _part), do: 0
  def parse(<<?(, rest::binary>>, part), do: decompress(rest, "", part)
  def parse(<<_a, rest::binary>>, part), do: 1 + parse(rest, part)

  def decompress(<<?), data::binary>>, scheme, part) do
    [count, times] =
      String.split(scheme, "x", trim: true)
      |> Enum.map(&String.to_integer/1)

    <<repeat::bytes-size(count), rest::binary>> = data

    case part do
      1 -> times * count + parse(rest, part)
      2 -> times * parse(repeat, part) + parse(rest, part)
    end
  end

  def decompress(<<a, rest::binary>>, scheme, part),
    do: decompress(rest, scheme <> <<a>>, part)

  def solution1(input) do
    parse(input, 1)
  end

  def solution2(input) do
    parse(input, 2)
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  112830
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  10931789799
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
