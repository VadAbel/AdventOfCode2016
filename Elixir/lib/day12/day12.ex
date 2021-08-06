defmodule Aoc2016.Day12 do
  @day "12"
  @input_file "../inputs/day#{@day}.txt"

  @register_label ~w(a b c d)

  def parse_line(line) do
    [instruction | operande] = String.split(line, " ", trim: true)

    [
      instruction
      | Enum.map(operande, fn
          x when x in @register_label -> x
          x -> String.to_integer(x)
        end)
    ]
    |> List.to_tuple()
  end

  def process(instructions, register),
    do: exec(instructions[register.pointer], register, instructions)

  def exec(nil, register, _instructions), do: register["a"]

  def exec({"cpy", x, y}, register, instructions) when y in @register_label,
    do:
      process(instructions, %{
        register
        | y => Map.get(register, x, x),
          pointer: register.pointer + 1
      })

  def exec({"inc", x}, register, instructions) when x in @register_label,
    do:
      process(
        instructions,
        %{
          register
          | x => register[x] + 1,
            pointer: register.pointer + 1
        }
      )

  def exec({"dec", x}, register, instructions) when x in @register_label,
    do:
      process(
        instructions,
        %{
          register
          | x => register[x] - 1,
            pointer: register.pointer + 1
        }
      )

  def exec({"jnz", x, y}, register, instructions),
    do:
      process(
        instructions,
        %{
          register
          | pointer:
              register.pointer +
                if(Map.get(register, x, x) == 0,
                  do: 1,
                  else: Map.get(register, y, y)
                )
        }
      )

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.with_index(&{&2, &1})
    |> Enum.into(%{})
    |> process(%{
      "a" => 0,
      "b" => 0,
      "c" => 0,
      "d" => 0,
      pointer: 0
    })
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.with_index(&{&2, &1})
    |> Enum.into(%{})
    |> process(%{
      "a" => 0,
      "b" => 0,
      "c" => 1,
      "d" => 0,
      pointer: 0
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
