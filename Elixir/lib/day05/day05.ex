defmodule Aoc2016.Day05 do
  @day "05"
  @input_file "../inputs/day#{@day}.txt"

  defp md5(door), do: :crypto.hash(:md5, door) |> Base.encode16(case: :lower)

  @doc """
  iex>Aoc2016.Day05.find_password_part1("abc", 1, 1)
  '1'
  iex>Aoc2016.Day05.find_password_part1("abc", 1, 3)
  '18f'
  """
  def find_password_part1(_doorID, _index, 0), do: []

  def find_password_part1(doorID, index, time) do
    case md5(doorID <> Integer.to_string(index)) do
      <<"00000", char, _rest::binary>> ->
        [char | find_password_part1(doorID, index + 1, time - 1)]

      _ ->
        find_password_part1(doorID, index + 1, time)
    end
  end

  @doc """
  iex>Aoc2016.Day05.find_password_part2("abc", 1, %{}, 8)
  '05ace8e3'
  """
  def find_password_part2(_doorID, _index, password, lenght) when map_size(password) == lenght,
    do: Map.values(password)

  def find_password_part2(doorID, index, password, lenght) do
    case md5(doorID <> Integer.to_string(index)) do
      <<"00000", position, char, _rest::binary>> when position in ?0..(?0 + lenght - 1) ->
        find_password_part2(doorID, index + 1, Map.put_new(password, position, char), lenght)

      _ ->
        find_password_part2(doorID, index + 1, password, lenght)
    end
  end

  def solution1(input) do
    find_password_part1(input, 1, 8)
    |> List.to_string()
  end

  def solution2(input) do
    find_password_part2(input, 1, %{}, 8)
    |> List.to_string()
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
