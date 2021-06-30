defmodule Aoc2016.Day07 do
  @day "07"
  @input_file "../inputs/day#{@day}.txt"

  def parse_ipv7(ipv7) do
    String.split(ipv7, ["[", "]"])
    |> then(
      &Map.new([{:out_bracket, Enum.take_every(&1, 2)}, {:in_bracket, Enum.drop_every(&1, 2)}])
    )
  end

  def is_support_tls(ipv7_map) do
    Enum.map(ipv7_map[:out_bracket], &has_abba(&1)) |> Enum.any?() and
      Enum.map(ipv7_map[:in_bracket], &(!has_abba(&1))) |> Enum.all?()
  end

  def is_support_ssl(ipv7_map) do
    Enum.map(ipv7_map[:out_bracket], &has_aba(&1, ipv7_map[:in_bracket]))
    |> Enum.any?()
  end

  def has_abba(sequence) when byte_size(sequence) < 4, do: false
  def has_abba(<<a, b, b, a, _rest::binary>>) when a != b, do: true
  def has_abba(<<_a, rest::binary>>), do: has_abba(rest)

  def has_aba(sequence, _in_bracket) when byte_size(sequence) < 3, do: false

  def has_aba(<<a, b, a, rest::binary>>, in_bracket) when a != b do
    case Enum.map(in_bracket, &String.contains?(&1, <<b, a, b>>)) |> Enum.any?() do
      true ->
        true

      false ->
        has_aba(<<b, a, rest::binary>>, in_bracket)
    end
  end

  def has_aba(<<_a, rest::binary>>, in_bracket), do: has_aba(rest, in_bracket)

  def solution1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_ipv7(&1))
    |> Enum.filter(&is_support_tls(&1))
    |> Enum.count()
  end

  def solution2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_ipv7(&1))
    |> Enum.filter(&is_support_ssl(&1))
    |> Enum.count()
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  115
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  231
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
