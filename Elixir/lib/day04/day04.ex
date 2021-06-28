defmodule Aoc2016.Day04 do
  @day "04"
  @input_file "../inputs/day#{@day}.txt"

  @format ~r/^(?<encrypted_name>[[:alpha:]-]+)-(?<sectorID>[[:digit:]]+)\[(?<checksum>[[:alpha:]]+)\]$/

  def parse(input) do
    Regex.named_captures(@format, input)
    |> Map.new(fn {key, value} -> {String.to_existing_atom(key), value} end)
    |> update_in([:sectorID], &String.to_integer/1)
  end

  def validate_room(room_map) do
    if is_valid_room(room_map[:encrypted_name], room_map[:checksum]),
      do: room_map[:sectorID],
      else: 0
  end

  @doc """
  iex> Aoc2016.Day#{@day}.is_valid_room("aaaaa-bbb-z-y-x", "abxyz")
  true
  iex> Aoc2016.Day#{@day}.is_valid_room("totally-real-room", "decoy")
  false
  """
  def is_valid_room(encrypted_name, checksum) do
    checksum ==
      String.replace(encrypted_name, "-", "")
      |> String.graphemes()
      |> Enum.frequencies()
      |> Enum.group_by(fn {_, count} -> count end, fn {char, _} -> char end)
      |> Enum.sort(:desc)
      |> Enum.flat_map(fn {_, x} -> Enum.sort(x) end)
      |> Enum.take(5)
      |> List.to_string()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.decrypt_room("qzmt-zixmtkozy-ivhz", 343)
  "very encrypted name"
  """
  def decrypt_room("", _rot), do: ""
  def decrypt_room(<<?-, rest::binary>>, rot), do: <<?\s>> <> decrypt_room(rest, rot)

  def decrypt_room(<<head, rest::binary>>, rot) when head in ?a..?z,
    do: <<Integer.mod(head - ?a + rot, 26) + ?a>> <> decrypt_room(rest, rot)

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.map(&validate_room/1)
    |> Enum.sum()
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.filter(&is_valid_room(&1[:encrypted_name], &1[:checksum]))
    |> Enum.map(&put_in(&1, [:room], decrypt_room(&1[:encrypted_name], &1[:sectorID])))
    |> Enum.filter(&String.contains?(&1[:room], "north"))
    |> then(&hd(&1)[:sectorID])
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  185371
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  984
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
