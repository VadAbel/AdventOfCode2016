defmodule Aoc2016.Day13 do
  @day "13"
  @input_file "../inputs/day#{@day}.txt"

  @start_coord {1, 1}
  @target {31, 39}

  defmodule OfficeMap do
    use Agent

    def start_link(initial_value) do
      {:ok, pid} = Agent.start_link(fn -> MapSet.new(initial_value) end)
      pid
    end

    def get(pid) do
      Agent.get(pid, fn state -> state end)
    end

    def new_and_update(border, pid) do
      Agent.get_and_update(
        pid,
        fn state ->
          {MapSet.difference(MapSet.new(border), state) |> MapSet.to_list(),
           MapSet.union(state, MapSet.new(border))}
        end
      )
    end
  end

  def get_neighbors({x, y}) do
    [
      {x - 1, y},
      {x + 1, y},
      {x, y - 1},
      {x, y + 1}
    ]
    |> Enum.reject(fn {x, y} -> x < 0 or y < 0 end)
  end

  def open_space?({x, y}, number) do
    (x * x + 3 * x + 2 * x * y + y + y * y + number)
    |> Integer.digits(2)
    |> Enum.sum()
    |> then(&(rem(&1, 2) == 0))
  end

  def get_new_border(border, office_map, number) do
    border
    |> Enum.flat_map(&get_neighbors/1)
    |> OfficeMap.new_and_update(office_map)
    |> Enum.filter(&open_space?(&1, number))
  end

  def process_go_to(number, border, office_map, target, turn \\ 0) do
    if target in border,
      do: turn,
      else:
        process_go_to(
          number,
          get_new_border(border, office_map, number),
          office_map,
          target,
          turn + 1
        )
  end

  def process_how_many(number, _border, office_map, turn \\ 0)

  def process_how_many(number, _border, office_map, turn) when turn == 50 do
    OfficeMap.get(office_map)
    |> Enum.count(&open_space?(&1, number))
  end

  def process_how_many(number, border, office_map, turn) do
    process_how_many(
      number,
      get_new_border(border, office_map, number),
      office_map,
      turn + 1
    )
  end

  def solution1(input, target \\ @target) do
    input
    |> String.to_integer()
    |> process_go_to(
      [@start_coord],
      OfficeMap.start_link([@start_coord]),
      target
    )
  end

  def solution2(input) do
    input
    |> String.to_integer()
    |> process_how_many(
      [@start_coord],
      OfficeMap.start_link([@start_coord])
    )
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  90
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  135
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
