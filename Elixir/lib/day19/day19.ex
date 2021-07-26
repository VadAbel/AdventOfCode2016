defmodule Aoc2016.Day19 do
  @day "19"
  @input_file "../inputs/day#{@day}.txt"

  def process_part1(to_process, buffer \\ [])
  def process_part1([elf], []), do: elf
  def process_part1([], buffer), do: process_part1(Enum.reverse(buffer))
  def process_part1([x], buffer), do: process_part1([x | Enum.reverse(buffer)])
  def process_part1([x, _ | tail], buffer), do: process_part1(tail, [x | buffer])

  def process_part2([elf]), do: elf

  def process_part2(elfs) do
    l = length(elfs) |> div(2)
    elfs_chunk = Enum.chunk_every(elfs, l)

    process_part2(
      Enum.at(elfs_chunk, 0, []),
      Enum.at(elfs_chunk, 1, []),
      Enum.at(elfs_chunk, 2, []),
      [],
      []
    )
  end

  def process_part2([], y, buffer, buffer_x, buffer_y) do
    (Enum.reverse(buffer_x) ++ y ++ Enum.reverse(buffer ++ buffer_y))
    |> process_part2()
  end

  def process_part2(x, [], buffer, buffer_x, buffer_y),
    do: process_part2(x, Enum.reverse(buffer_y), buffer, buffer_x, [])

  def process_part2(x, [y | tail_y], [b1, b2], buffer_x, buffer_y),
    do: process_part2(x, tail_y, [], [y | buffer_x], [b1, b2 | buffer_y])

  def process_part2([x | tail_x], [_y | tail_y], buffer, buffer_x, buffer_y),
    do: process_part2(tail_x, tail_y, [x | buffer], buffer_x, buffer_y)

  def solution1(input) do
    input
    |> String.to_integer()
    |> then(&process_part1(Enum.to_list(1..&1)))
  end

  def solution2(input) do
    input
    |> String.to_integer()
    |> then(&process_part2(Enum.to_list(1..&1)))
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  1842613
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  1424135
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
