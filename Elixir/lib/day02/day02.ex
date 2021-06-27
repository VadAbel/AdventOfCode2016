defmodule Aoc2016.Day02 do
  @day "02"
  @input_file "../inputs/day#{@day}.txt"

  def parse(orders) do
    String.graphemes(orders)
    |> Enum.map(&String.to_atom/1)
  end

  def move({x, y}, :U), do: {x, validate(y - 1)}
  def move({x, y}, :D), do: {x, validate(y + 1)}
  def move({x, y}, :L), do: {validate(x - 1), y}
  def move({x, y}, :R), do: {validate(x + 1), y}

  defp validate(number, min..max \\ 0..2), do: max(min, min(number, max))

  def position_to_digit({x, y}) do
    Integer.to_string(y * 3 + x + 1)
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.scan({1, 1}, fn orders, last_position ->
      parse(orders)
      |> Enum.reduce(last_position, fn order, position ->
        move(position, order)
      end)
    end)
    |> Enum.map(&position_to_digit/1)
    |> List.to_string()
  end

  def solution2(input) do
    input
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

  # @doc """
  # iex> Aoc2016.Day01.part2()
  # 153
  # """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
