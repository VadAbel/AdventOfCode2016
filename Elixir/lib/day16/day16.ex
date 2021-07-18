defmodule Aoc2016.Day16 do
  require Integer

  @day "16"
  @input_file "../inputs/day#{@day}.txt"

  def dragon_curve(a, length) do
    if String.length(a) < length do
      dragon_curve(a <> "0" <> (a |> inverse()), length)
    else
      String.slice(a, 0, length)
    end
  end

  def inverse(<<>>), do: <<>>
  def inverse(<<?0, rest::binary>>), do: inverse(rest) <> <<?1>>
  def inverse(<<?1, rest::binary>>), do: inverse(rest) <> <<?0>>

  # This checksum is faster take less memory but need to reverse if this one is exec odd time
  def checksum_s(<<>>), do: <<>>
  def checksum_s(<<a::8, b::8, rest::binary>>) when a != b, do: checksum_s(rest) <> <<?0>>
  def checksum_s(<<a::8, b::8, rest::binary>>) when a == b, do: checksum_s(rest) <> <<?1>>

  def checksum(a, time \\ 0) do
    if(Integer.is_even(String.length(a))) do
      checksum_s(a)
      |> checksum(time + 1)
    else
      if Integer.is_odd(time),
        do: String.reverse(a),
        else: a
    end
  end

  def solution1(input, length \\ 272) do
    input
    |> dragon_curve(length)
    |> checksum()
  end

  def solution2(input, length \\ 35_651_584) do
    input
    |> dragon_curve(length)
    |> checksum()
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
