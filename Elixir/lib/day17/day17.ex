defmodule Aoc2016.Day17 do
  @day "17"
  @input_file "../inputs/day#{@day}.txt"

  defmacro md5(s) do
    quote do
      :crypto.hash(:md5, unquote(s))
    end
  end

  def possible_doors(password, path, {x, y}) do
    <<up::4, down::4, left::4, right::4, _rest::binary>> = md5(password <> path)

    for {direction, {x, y}, value} <-
          [
            {"U", {x, y - 1}, up},
            {"D", {x, y + 1}, down},
            {"L", {x - 1, y}, left},
            {"R", {x + 1, y}, right}
          ],
        value in 11..15,
        x in 0..3,
        y in 0..3,
        do: {direction, {x, y}}
  end

  def next_step(password, paths_room) do
    for {path, room} <- paths_room,
        {direction, new_room} <- possible_doors(password, path, room),
        do: {path <> direction, new_room}
  end

  def process_part1(password, paths_room) do
    new_paths_room = next_step(password, paths_room)
    vault = Enum.filter(new_paths_room, fn {_, room} -> room == {3, 3} end)

    if Enum.empty?(vault),
      do: process_part1(password, new_paths_room),
      else: hd(vault) |> elem(0)
  end

  def process_part2(password, paths_room, step \\ 1, last \\ nil)
  def process_part2(_password, [], _step, last), do: last

  def process_part2(password, paths_room, step, last) do
    {vault, new_paths_room} =
      next_step(password, paths_room) |> Enum.split_with(fn {_, room} -> room == {3, 3} end)

    process_part2(
      password,
      new_paths_room,
      step + 1,
      if(Enum.empty?(vault),
        do: last,
        else: step
      )
    )
  end

  def solution1(input) do
    process_part1(input, [{"", {0, 0}}])
  end

  def solution2(input) do
    process_part2(input, [{"", {0, 0}}])
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  "DDRRUDLRRD"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  488
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
