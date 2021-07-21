defmodule Aoc2016.Day16 do
  require Integer
  use Bitwise, only_operators: true

  @day "16"
  @input_file "../inputs/day#{@day}.txt"

  def dragon_curve(a, length) do
    inv_a =
      Enum.reduce(a, [], fn
        ?0, acc -> [?1 | acc]
        ?1, acc -> [?0 | acc]
      end)

    [
      Stream.cycle([a, inv_a]),
      Stream.iterate(1, &(&1 + 1))
      |> Stream.map(&calc_jointer/1)
    ]
    |> Stream.zip()
    |> Stream.flat_map(fn {x, jointer} -> x ++ [jointer] end)
    |> Stream.take(length)
  end

  defp calc_jointer(x) when x > 0 do
    cond do
      (x &&& 1) == 0 -> calc_jointer(x >>> 1)
      (x &&& 2) == 0 -> ?0
      (x &&& 2) == 2 -> ?1
    end
  end

  def checksum(dragon, length) do
    Stream.iterate({length, dragon}, fn {l, d} ->
      {div(l, 2),
       d
       |> Stream.chunk_every(2)
       |> Stream.map(fn
         [x, x] -> ?1
         _ -> ?0
       end)}
    end)
    |> Stream.drop_while(fn {l, _} -> Integer.is_even(l) end)
    |> Enum.take(1)
    |> hd()
    |> elem(1)
  end

  def solution1(input, length \\ 272) do
    input
    |> String.to_charlist()
    |> dragon_curve(length)
    |> checksum(length)
    |> Enum.to_list()
    |> List.to_string()
  end

  def solution2(input, length \\ 35_651_584) do
    input
    |> String.to_charlist()
    |> dragon_curve(length)
    |> checksum(length)
    |> Enum.to_list()
    |> List.to_string()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  "00100111000101111"
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  "11101110011100110"
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
