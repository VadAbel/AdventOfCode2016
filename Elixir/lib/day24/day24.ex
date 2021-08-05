defmodule Aoc2016.Day24 do
  @day "24"
  @input_file "../inputs/day#{@day}.txt"

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.map(&Tuple.append(&1, y))
    end)
    |> Enum.reduce({MapSet.new(), %{}}, fn
      {?#, _x, _y}, acc ->
        acc

      {a, x, y}, {open, waypoint} ->
        {
          MapSet.put(open, {x, y}),
          if(a != ?., do: Map.put(waypoint, {x, y}, List.to_integer([a])), else: waypoint)
        }
    end)
  end

  def calc_path_chunk(open, waypoint) do
    [h | t] = Map.keys(waypoint)

    Enum.scan(t, [h], &[&1 | &2])
    |> Enum.flat_map(fn [start | target] ->
      find_path_chunk(open, [start], target, MapSet.new([start]))
      |> Enum.map(fn {target, distance} ->
        {[waypoint[start], waypoint[target]] |> Enum.sort(), distance}
      end)
    end)
    |> Map.new()
  end

  def find_path_chunk(open, border, target, visited, path_find \\ [], turn \\ 1)

  def find_path_chunk(_open, _border, [], _visited, path_find, _turn), do: path_find

  def find_path_chunk(open, border, target, visited, path_find, turn) do
    new_border =
      for cell <- border,
          new_cell <- neightbor(cell),
          MapSet.member?(open, new_cell),
          not MapSet.member?(visited, new_cell),
          reduce: MapSet.new() do
        acc -> MapSet.put(acc, new_cell)
      end

    {target_find, new_target} = Enum.split_with(target, &MapSet.member?(new_border, &1))

    find_path_chunk(
      open,
      new_border,
      new_target,
      MapSet.union(visited, new_border),
      Enum.reduce(target_find, path_find, &[{&1, turn} | &2]),
      turn + 1
    )
  end

  def neightbor({x, y}) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {a, b} -> {a + x, b + y} end)
  end

  def permutation([]), do: [[]]
  def permutation(list), do: for(x <- list, rest <- permutation(list -- [x]), do: [x | rest])

  def solution1(input) do
    {open, waypoint} = input |> parse()

    path_chunk = calc_path_chunk(open, waypoint)

    permutation(Map.values(waypoint) -- [0])
    |> Enum.map(fn x ->
      Enum.chunk_every([0 | x], 2, 1, :discard)
      |> Enum.map(&path_chunk[Enum.sort(&1)])
      |> Enum.sum()
    end)
    |> Enum.min()
  end

  def solution2(input) do
    {open, waypoint} = input |> parse()

    path_chunk = calc_path_chunk(open, waypoint)

    permutation(Map.values(waypoint) -- [0])
    |> Enum.map(fn x ->
      Enum.chunk_every([0 | x], 2, 1, [0])
      |> Enum.map(&path_chunk[Enum.sort(&1)])
      |> Enum.sum()
    end)
    |> Enum.min()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  490
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  744
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
