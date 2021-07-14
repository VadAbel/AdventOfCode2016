defmodule Aoc2016.Day12 do
  @day "12"
  @input_file "../inputs/day#{@day}.txt"

  def parse_line(line) do
    [instruction | operande] = String.split(line, " ", trim: true)

    Enum.reduce(operande, {instruction}, fn x, acc ->
      Tuple.append(
        acc,
        case x do
          <<x>> when x in ?a..?d -> <<x>>
          _ -> String.to_integer(x)
        end
      )
    end)
  end

  def process(instructions, {register, pointer}) when pointer >= length(instructions),
    do: register["a"]

  def process(instructions, {register, pointer}) do
    process(
      instructions,
      exec(Enum.at(instructions, pointer), {register, pointer})
    )
  end

  def exec({"cpy", x, y}, {register, pointer}),
    do: {
      Map.put(register, y, Map.get(register, x, x)),
      pointer + 1
    }

  def exec({"inc", x}, {register, pointer}),
    do: {
      Map.update!(register, x, &(&1 + 1)),
      pointer + 1
    }

  def exec({"dec", x}, {register, pointer}),
    do: {
      Map.update!(register, x, &(&1 - 1)),
      pointer + 1
    }

  def exec({"jnz", x, y}, {register, pointer}),
    do: {
      register,
      pointer + if(register[x] == 0, do: 1, else: y)
    }

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> process({
      %{
        "a" => 0,
        "b" => 0,
        "c" => 0,
        "d" => 0
      },
      0
    })
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> process({
      %{
        "a" => 0,
        "b" => 0,
        "c" => 1,
        "d" => 0
      },
      0
    })
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  318083
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  9227737
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
