defmodule Aoc2016.Day22 do
  @day "22"
  @input_file "../inputs/day#{@day}.txt"

  def parse(input) do
    input
    |> Enum.drop(2)
    |> Enum.map(&parse_line/1)
  end

  def parse_line(line) do
    [node, size, used, avail, _use_percent] = String.split(line, " ", trim: true)

    %{
      name: parse_node(node),
      size: parse_size(size),
      used: parse_size(used),
      avail: parse_size(avail)
    }
  end

  def parse_node(node_string) do
    [_, "x" <> x, "y" <> y] =
      node_string
      |> String.split("/", trim: true)
      |> List.last()
      |> String.split("-", trim: true)

    [x, y]
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def parse_size(size_string) do
    "T" <> size_reverse = String.reverse(size_string)

    String.reverse(size_reverse)
    |> String.to_integer()
  end

  def find_pair(nodes_list) do
    for node_a <- nodes_list,
        node_a.used > 0,
        node_b <- nodes_list -- [node_a],
        node_b.avail >= node_a.used,
        do: {node_a, node_b}
  end

  def neighbor({x, y}) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {a_x, a_y} -> {a_x + x, a_y + y} end)
  end

  def process_part2(node_list, state_list, saved_state, turn) do
    new_state_list =
      for {empty_node, data_node} <- state_list,
          new_empty <- neighbor(empty_node),
          MapSet.member?(node_list, new_empty),
          new_data = if(new_empty == data_node, do: empty_node, else: data_node),
          not MapSet.member?(saved_state, {new_empty, new_data}),
          reduce: MapSet.new() do
        acc -> MapSet.put(acc, {new_empty, new_data})
      end

    if Enum.any?(new_state_list, &(elem(&1, 1) == {0, 0})),
      do: turn,
      else:
        process_part2(
          node_list,
          new_state_list,
          MapSet.union(saved_state, new_state_list),
          turn + 1
        )
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> parse()
    |> find_pair()
    |> Enum.count()
  end

  def solution2(input) do
    node_map =
      input
      |> String.split("\n", trim: true)
      |> parse()

    empty_node =
      node_map
      |> get_in([Access.filter(&(&1.used == 0))])
      |> hd()

    data_node =
      node_map
      |> get_in([Access.filter(&(&1.name |> elem(1) == 0))])
      |> Enum.max_by(&elem(&1.name, 0))

    node_state = [{empty_node.name, data_node.name}]

    node_map
    |> get_in([Access.filter(&(&1.used <= empty_node.size)), :name])
    |> MapSet.new()
    |> process_part2(node_state, MapSet.new([node_state]), 1)
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  1043
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  185
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
