defmodule Aoc2016.Day05 do
  @day "05"
  @input_file "../inputs/day#{@day}.txt"

  def md5_generator(doorID) do
    Stream.iterate(1, &(&1 + 1))
    |> Stream.map(&:crypto.hash(:md5, doorID <> Integer.to_string(&1)))
    |> Stream.filter(fn <<a::20, _::4, _::binary>> -> a == 0 end)
    |> Stream.map(fn <<_a::20, b::4, c::4, _::4, _::binary>> -> {b, c} end)
  end

  def solution1(input) do
    md5_generator(input)
    |> Enum.take(8)
    |> Enum.reduce("", fn {char, _}, acc -> acc <> Integer.to_string(char, 16) end)
    |> String.downcase()
  end

  def solution2(input) do
    md5_generator(input)
    |> Enum.reduce_while(%{}, fn
      {position, char}, acc when position in 0..7 ->
        password = Map.put_new(acc, position, Integer.to_string(char, 16))

        if map_size(password) == 8,
          do: {:halt, password},
          else: {:cont, password}

      {_position, _char}, acc ->
        {:cont, acc}
    end)
    |> Map.values()
    |> List.to_string()
    |> String.downcase()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  "c6697b55"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  "8c35d1ab"
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
