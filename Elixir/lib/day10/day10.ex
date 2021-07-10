defmodule Aoc2016.Day10 do
  @day "10"
  @input_file "../inputs/day#{@day}.txt"

  def parse(input) do
    input
    |> Enum.map(&parse_line(&1))
    |> Enum.reduce(%{input: %{}, bot: %{}, output: %{}}, fn {type, map}, acc ->
      Map.update!(
        acc,
        type,
        &Map.merge(&1, map, fn _key, ml, mr ->
          Map.merge(ml, mr, fn :value, vl, vr -> MapSet.union(vl, vr) end)
        end)
      )
    end)
  end

  def parse_line(input) do
    format_input =
      String.replace(input, ["and", "gives", "goes", "to"], "")
      |> String.split(" ", trim: true)

    case format_input do
      ["value", value, "bot", bot_no] ->
        {:input, %{String.to_integer(bot_no) => %{value: MapSet.new([String.to_integer(value)])}}}

      ["bot", bot_no | outputs] ->
        {:bot,
         %{
           String.to_integer(bot_no) =>
             outputs
             |> Enum.chunk_every(3)
             |> Enum.reduce(%{}, fn [where, type, no], acc ->
               Map.put(acc, String.to_atom(where), {String.to_atom(type), String.to_integer(no)})
             end)
         }}
    end
  end

  def process(factory_map) do
    get_in(factory_map, [:input])
    |> Enum.reduce(factory_map, fn {bot_no, %{value: val}}, acc ->
      update_in(acc, [:bot, bot_no, Access.key(:value, val)], &MapSet.union(&1, val))
      |> process_bot(:bot, bot_no)
    end)
  end

  def process_bot(factory_map, :output, _bot_no), do: factory_map

  def process_bot(factory_map, :bot, bot_no),
    do: process_bot(factory_map, :bot, bot_no, Enum.count(factory_map[:bot][bot_no][:value]))

  def process_bot(factory_map, :bot, _bot_no, nb_chip) when nb_chip < 2, do: factory_map

  def process_bot(factory_map, :bot, bot_no, nb_chip) when nb_chip == 2 do
    bot = factory_map[:bot][bot_no]

    [
      {bot[:low], Enum.min(bot[:value])},
      {bot[:high], Enum.max(bot[:value])}
    ]
    |> Enum.reduce(factory_map, fn {{type, no}, val}, acc ->
      update_in(
        acc,
        [type, Access.key(no, %{}), Access.key(:value, MapSet.new([val]))],
        &MapSet.put(&1, val)
      )
      |> process_bot(type, no)
    end)
  end

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> parse()
    |> process()
    |> Map.get(:bot)
    |> Enum.filter(fn {_bot_no, %{value: val}} -> val == MapSet.new([61, 17]) end)
    |> then(fn x ->
      [{bot, _}] = x
      bot
    end)
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> parse()
    |> process()
    |> then(
      &Enum.flat_map(0..2, fn x -> get_in(&1, [:output, x, :value]) |> MapSet.to_list() end)
    )
    |> Enum.product()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  27
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  13727
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
