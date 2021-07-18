defmodule Aoc2016.Day15 do
  @day "15"
  @input_file "../inputs/day#{@day}.txt"

  def parse(line) do
    String.split(
      line,
      ["Disc #", " has ", " positions; at time=", ", it is at position ", "."],
      trim: true
    )
    |> Enum.map(&String.to_integer/1)
  end

  def process(maze, turn \\ 0) do
    if maze
       |> Enum.all?(fn [disc, nb_position, init_time, init_position] ->
         rem(
           turn + disc + init_position - init_time,
           nb_position
         ) == 0
       end),
       do: turn,
       else: process(maze, turn + 1)
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> process()
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> then(&[[(Enum.map(&1, fn x -> hd(x) end) |> Enum.max()) + 1, 11, 0, 0] | &1])
    |> process()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  121834
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  3208099
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
