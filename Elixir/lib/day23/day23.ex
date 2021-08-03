defmodule Aoc2016.Day23 do
  @day "23"
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

  def exec({"cpy", x, y}, register, instructions) when y in @register_label do
    new_register =
      with {"cpy", b, c} <- instructions[register.pointer],
           {"inc", a} <- instructions[register.pointer + 1],
           {"dec", ^c} <- instructions[register.pointer + 2],
           {"jnz", ^c, -2} <- instructions[register.pointer + 3],
           {"dec", d} <- instructions[register.pointer + 4],
           {"jnz", ^d, -5} <- instructions[register.pointer + 5] do
        %{
          register
          | a => register[a] + Map.get(register, b, b) * Map.get(register, d, d),
            c => 0,
            d => 0,
            pointer: register.pointer + 6
        }
      else
        _ ->
          %{
            register
            | y => Map.get(register, x, x),
              pointer: register.pointer + 1
          }
      end

    process(instructions, new_register)
  end

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

  def exec({"tgl", x}, register, instructions) when x in @register_label do
    target_index = register.pointer + register[x]

    process(
      case instructions[target_index] do
        {"inc", a} -> %{instructions | target_index => {"dec", a}}
        {_, a} -> %{instructions | target_index => {"inc", a}}
        {"jnz", a, b} -> %{instructions | target_index => {"cpy", a, b}}
        {_, a, b} -> %{instructions | target_index => {"jnz", a, b}}
        _ -> instructions
      end,
      %{register | pointer: register.pointer + 1}
    )
  end

  def exec(_, register, instructions),
    do:
      process(
        instructions,
        %{register | pointer: register.pointer + 1}
      )

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.with_index(&{&2, &1})
    |> Enum.into(%{})
    |> process(%{
      "a" => 7,
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
      "a" => 12,
      "b" => 0,
      "c" => 0,
      "d" => 0,
      pointer: 0
    })
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  13685
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  479010245
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
