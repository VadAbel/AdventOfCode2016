defmodule Aoc2016.Day21 do
  @day "21"
  @input_file "../inputs/day#{@day}.txt"

  def parse(line) when is_binary(line) do
    String.split(line, [" ", "with", "step", "steps", "based", " on ", "of", "to"], trim: true)
    |> parse()
  end

  def parse(["swap", type, x, type, y]),
    do:
      {"swap",
       [x, y]
       |> Enum.map(
         case type do
           "position" -> &String.to_integer/1
           "letter" -> &String.to_charlist/1
         end
       )}

  def parse(["rotate", way, x]),
    do: {"rotate", [way, String.to_integer(x)]}

  def parse(["rotate", "position", "letter", x]),
    do: {"rotate", String.to_charlist(x)}

  def parse(["reverse", "positions", x, "through", y]),
    do: {"reverse", [x, y] |> Enum.map(&String.to_integer/1)}

  def parse(["move", "position", x, "position", y]),
    do: {"move", [x, y] |> Enum.map(&String.to_integer/1)}

  def exec_instruction({"swap", [x, y]}, password) when is_integer(x) do
    password
    |> List.replace_at(x, Enum.at(password, y))
    |> List.replace_at(y, Enum.at(password, x))
  end

  def exec_instruction({"swap", [x, y]}, password) when is_list(x) do
    indexs =
      [x, y]
      |> Enum.map(fn [a] ->
        Enum.find_index(password, &(&1 == a))
      end)

    exec_instruction({"swap", indexs}, password)
  end

  def exec_instruction({"rotate", [way, count]}, password) do
    Enum.split(
      password,
      case way do
        "left" -> count
        "right" -> -count
      end
    )
    |> then(fn {a, b} -> b ++ a end)
  end

  def exec_instruction({"rotate", [x]}, password) do
    index = Enum.find_index(password, &(&1 == x))

    count =
      rem(
        if(index < 4, do: index + 1, else: index + 2),
        length(password)
      )

    exec_instruction({"rotate", ["right", count]}, password)
  end

  def exec_instruction({"reverse", [x, y]}, position),
    do: Enum.reverse_slice(position, x, y - x + 1)

  def exec_instruction({"move", [x, y]}, password) do
    password
    |> List.pop_at(x)
    |> then(fn {a, b} -> List.insert_at(b, y, a) end)
  end

  def permutation([]), do: [[]]
  def permutation(list), do: for(x <- list, rest <- permutation(list -- [x]), do: [x | rest])

  def solution1(input, password \\ ?a..?h) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.reduce(Enum.to_list(password), &exec_instruction/2)
    |> to_string()
  end

  def solution2(input, scrambled_password \\ 'fbgdceah') do
    instructions =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)

    permutation(scrambled_password)
    |> Stream.drop_while(fn password ->
      Enum.reduce(instructions, password, &exec_instruction/2) !=
        scrambled_password
    end)
    |> Enum.take(1)
    |> hd()
    |> to_string()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  "cbeghdaf"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  "bacdefgh"
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
