defmodule Aoc2016.Day01 do
  @day "01"
  @input_file "../inputs/day#{@day}.txt"

  @north 0
  @east 1
  @south 2
  @west 3

  def parse(order) do
    {turn_direction, step} = String.next_grapheme(order)
    {String.to_atom(turn_direction), String.to_integer(step)}
  end

  def turn(face, :R), do: Integer.mod(face + 1, 4)
  def turn(face, :L), do: Integer.mod(face - 1, 4)

  def walk(direction, position, step \\ 1)
  def walk(@north, {x, y}, step), do: {@north, {x, y + step}}
  def walk(@east, {x, y}, step), do: {@east, {x + step, y}}
  def walk(@south, {x, y}, step), do: {@south, {x, y - step}}
  def walk(@west, {x, y}, step), do: {@west, {x - step, y}}

  def walk_bystep(_face, _postition, 0), do: []

  def walk_bystep(face, position, step) do
    {_, new_position} = walk(face, position)
    [new_position | walk_bystep(face, new_position, step - 1)]
  end

  def calc_distance({x, y}) do
    abs(x) + abs(y)
  end

  def solution1(input) do
    input
    |> String.split(", ", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.reduce({@north, {0, 0}}, fn {turn_direction, step}, {face, position} ->
      turn(face, turn_direction)
      |> walk(position, step)
    end)
    |> elem(1)
    |> calc_distance()
  end

  def solution2(input) do
    input
    |> String.split(", ", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.reduce({@north, [{0, 0}]}, fn {turn_direction, step}, {face, trace} ->
      new_face = turn(face, turn_direction)
      {new_face, trace ++ walk_bystep(new_face, List.last(trace), step)}
    end)
    |> elem(1)
    |> Enum.reduce_while([], fn position, trace ->
      if position in trace, do: {:halt, position}, else: {:cont, [position | trace]}
    end)
    |> calc_distance()
  end

  @doc """
  iex> Aoc2016.Day01.part1()
  271
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day01.part2()
  153
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
