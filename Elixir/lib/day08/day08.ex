defmodule Aoc2016.Day08 do
  @day "08"
  @input_file "../inputs/day#{@day}.txt"

  @map_size_x 50
  @map_size_y 6

  def init_screen_map(x_lenght, y_lenght) do
    for x <- 0..(x_lenght - 1),
        y <- 0..(y_lenght - 1),
        reduce: %{} do
      acc -> put_in(acc, [Access.key(x, %{}), y], false)
    end
  end

  def parse(<<"rect ", rest::binary>>) do
    {
      :rect,
      String.split(rest, "x", trim: true) |> Enum.map(&String.to_integer/1)
    }
  end

  def parse(<<"rotate column x=", rest::binary>>) do
    {
      :rotate_column,
      String.split(rest, " by ", trim: true) |> Enum.map(&String.to_integer/1)
    }
  end

  def parse(<<"rotate row y=", rest::binary>>) do
    {
      :rotate_row,
      String.split(rest, " by ", trim: true) |> Enum.map(&String.to_integer/1)
    }
  end

  def exec_order({:rect, [count_x, count_y]}, screen_map) do
    for x <- 0..(count_x - 1),
        y <- 0..(count_y - 1),
        reduce: screen_map do
      acc -> put_in(acc, [x, y], true)
    end
  end

  def exec_order({:rotate_column, [x, count]}, screen_map) do
    for y <- 0..(@map_size_y - 1),
        reduce: screen_map do
      acc -> put_in(acc, [x, Integer.mod(y + count, @map_size_y)], screen_map[x][y])
    end
  end

  def exec_order({:rotate_row, [y, count]}, screen_map) do
    for x <- 0..(@map_size_x - 1),
        reduce: screen_map do
      acc -> put_in(acc, [Integer.mod(x + count, @map_size_x), y], screen_map[x][y])
    end
  end

  def visu(screen_map) do
    for y <- 0..(@map_size_y - 1) do
      for x <- 0..(@map_size_x - 1) do
        if screen_map[x][y],
          do: "#",
          else: " "
      end
      |> Enum.join()
    end
    |> Enum.join("\n")
    |> IO.puts()
  end

  def solution1(input) do
    screen_map = init_screen_map(@map_size_x, @map_size_y)

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.reduce(screen_map, fn order, screen_map ->
      exec_order(order, screen_map)
    end)
    |> Map.values()
    |> Enum.map(&Map.values(&1))
    |> List.flatten()
    |> Enum.count(&(&1 == true))
  end

  def solution2(input) do
    screen_map = init_screen_map(@map_size_x, @map_size_y)

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.reduce(screen_map, fn order, screen_map ->
      exec_order(order, screen_map)
    end)
    |> visu()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  119
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  # @doc """
  # iex> Aoc2016.Day#{@day}.part2()
  # ZFHFSFOGPO
  # """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
