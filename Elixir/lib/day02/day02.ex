defmodule Aoc2016.Day02 do
  @day "02"
  @input_file "../inputs/day#{@day}.txt"

  @keypad2 %{
    {2, 0} => 1,
    {1, 1} => 2,
    {2, 1} => 3,
    {3, 1} => 4,
    {0, 2} => 5,
    {1, 2} => 6,
    {2, 2} => 7,
    {3, 2} => 8,
    {4, 2} => 9,
    {1, 3} => 10,
    {2, 3} => 11,
    {3, 3} => 12,
    {2, 4} => 13
  }

  def parse(orders) do
    String.graphemes(orders)
    |> Enum.map(&String.to_atom/1)
  end

  def move({x, y}, :U), do: {x, y - 1}
  def move({x, y}, :D), do: {x, y + 1}
  def move({x, y}, :L), do: {x - 1, y}
  def move({x, y}, :R), do: {x + 1, y}

  def move_part1(position, direction) do
    {x, y} = move(position, direction)
    {validate(x), validate(y)}
  end

  def move_part2(position, direction) do
    new_position = move(position, direction)

    if is_valid_part2?(new_position),
      do: new_position,
      else: position
  end

  defp validate(number, min..max \\ 0..2), do: max(min, min(number, max))

  defp is_valid_part2?(position), do: Map.has_key?(@keypad2, position)

  defp position_to_digit_part1({x, y}), do: Integer.to_string(y * 3 + x + 1)

  defp position_to_digit_part2(position), do: Integer.to_string(@keypad2[position], 16)

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.scan({1, 1}, fn orders, last_position ->
      parse(orders)
      |> Enum.reduce(last_position, fn order, position ->
        move_part1(position, order)
      end)
    end)
    |> Enum.map(&position_to_digit_part1/1)
    |> List.to_string()
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.scan({0, 2}, fn orders, last_position ->
      parse(orders)
      |> Enum.reduce(last_position, fn order, position ->
        move_part2(position, order)
      end)
    end)
    |> Enum.map(&position_to_digit_part2/1)
    |> List.to_string()
  end

  @doc """
  iex> Aoc2016.Day02.part1()
  "56855"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day02.part2()
  "B3C27"
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
