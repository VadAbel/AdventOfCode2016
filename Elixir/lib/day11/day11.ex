defmodule Aoc2016.Day11 do
  @day "11"
  @input_file "../inputs/day#{@day}.txt"

  defmodule SaveTowers do
    use Agent

    def start_link do
      Agent.start_link(fn -> MapSet.new() end, name: __MODULE__)
    end

    def add(tower) do
      Agent.update(__MODULE__, &MapSet.put(&1, compact(tower)))
    end

    def member_and_add?(tower) do
      Agent.get_and_update(__MODULE__, fn state ->
        compact_tower = compact(tower)
        {MapSet.member?(state, compact_tower), MapSet.put(state, compact_tower)}
      end)
    end

    defp compact({elevator, floors}) do
      {
        elevator,
        for(
          {x, items} <- floors,
          into: %{},
          do: {x, Enum.frequencies_by(items, &elem(&1, 0))}
        )
      }
    end
  end

  def parse(input),
    do: {1, Enum.reduce(input, %{}, fn line, acc -> Map.merge(acc, parse_line(line)) end)}

  def parse_line(line) do
    [floor | items] =
      line
      |> String.replace(
        ["The", "floor contains", "a ", "-compatible", "and ", ",", ".", "nothing relevant"],
        ""
      )
      |> String.split(" ", trim: true)

    %{floor_to_num(floor) => parse_items(items)}
  end

  defp floor_to_num("first"), do: 1
  defp floor_to_num("second"), do: 2
  defp floor_to_num("third"), do: 3
  defp floor_to_num("fourth"), do: 4

  defp parse_items(items) do
    items
    |> Enum.chunk_every(2)
    |> Enum.reduce(MapSet.new(), fn [element, type], acc ->
      MapSet.put(acc, {String.to_atom(type), element})
    end)
  end

  def process(towers, turn \\ 1) do
    new_towers =
      for {elevator, floors} <- towers,
          next_elevator <- elevator_available_move(elevator, floors),
          nb_items <- 1..2,
          items <- take_items(MapSet.to_list(floors[elevator]), nb_items),
          new_floors =
            floors
            |> Map.update!(elevator, &MapSet.difference(&1, MapSet.new(items)))
            |> Map.update!(next_elevator, &MapSet.union(&1, MapSet.new(items))),
          valid_floors?(new_floors),
          not SaveTowers.member_and_add?({next_elevator, new_floors}) do
        {next_elevator, new_floors}
      end

    if Enum.any?(new_towers, &finish?/1),
      do: turn,
      else: process(new_towers, turn + 1)
  end

  def finish?({_elevator, floors}), do: Enum.all?(1..3, &(floors[&1] |> MapSet.size() == 0))

  def valid_floors?(floors), do: Enum.all?(floors, fn {_, x} -> valid_floor?(x) end)

  defp valid_floor?(items) do
    map_items = Enum.group_by(items, &elem(&1, 0), &elem(&1, 1))
    m = Map.get(map_items, :microchip, [])
    g = Map.get(map_items, :generator, [])

    Enum.empty?(g) or Enum.all?(m, &(&1 in g))
  end

  def take_items(_list_elements, count) when count == 0, do: [[]]

  def take_items(list_elements, count) do
    for element <- list_elements,
        rest <- take_items(list_elements -- [element], count - 1),
        do: [element | rest]
  end

  defp elevator_available_move(position, floors) do
    available_floor = Enum.drop_while(1..4, &(MapSet.size(floors[&1]) == 0))

    [position - 1, position + 1]
    |> Enum.filter(&(&1 in available_floor))
  end

  def solution1(input) do
    {:ok, _pid} = SaveTowers.start_link()

    input
    |> String.split("\n", trim: true)
    |> parse()
    |> tap(&SaveTowers.add/1)
    |> then(&process([&1]))
  end

  def solution2(input) do
    {:ok, _pid} = SaveTowers.start_link()

    input
    |> String.split("\n", trim: true)
    |> parse()
    |> then(fn {elevator, tower} ->
      {elevator,
       Map.update!(
         tower,
         1,
         &MapSet.union(
           &1,
           MapSet.new(
             generator: "elerium",
             microchip: "elerium",
             generator: "dilithium",
             microchip: "dilithium"
           )
         )
       )}
    end)
    |> tap(&SaveTowers.add/1)
    |> then(&process([&1]))
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  33
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  57
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
