defmodule Aoc2016.Day14 do
  @day "14"
  @input_file "../inputs/day#{@day}.txt"

  def triplet(<<a::4, b::4, b::4, c::4, _rest::binary>>) when a == b or b == c,
    do: b

  def triplet(<<_::8, rest::binary>>),
    do: triplet(<<rest::binary>>)

  def triplet(<<>>),
    do: nil

  def quintet(<<a::4, b::4, b::4, b::4, b::4, c::4, rest::binary>>) when a == b or b == c,
    do: [b | quintet(<<b::4, c::4, rest::binary>>)]

  def quintet(<<_::8, rest::binary>>),
    do: quintet(<<rest::binary>>)

  def quintet(<<>>), do: []

  defmacro md5(s) do
    quote do
      :crypto.hash(:md5, unquote(s))
    end
  end

  def stretch(input, 0), do: input

  def stretch(input, count) do
    Enum.reduce(1..count, input, fn _, acc ->
      md5(acc) |> Base.encode16(case: :lower)
    end)
  end

  def hash_generator(salt, stretch_count \\ 0) do
    Stream.iterate(0, &(&1 + 1))
    |> Task.async_stream(fn index ->
      md5 =
        (salt <> Integer.to_string(index))
        |> stretch(stretch_count)
        |> md5()

      {
        index,
        triplet(md5),
        quintet(md5) |> Enum.uniq()
      }
    end)
    |> Stream.map(&elem(&1, 1))
    |> Stream.chunk_every(1 + 1000, 1)
    |> Stream.filter(fn [{_index, triplet, _quintet} | tail] ->
      not is_nil(triplet) and
        Enum.any?(tail, &(triplet in elem(&1, 2)))
    end)
    |> Stream.map(&(hd(&1) |> elem(0)))
  end

  def solution1(input) do
    hash_generator(input)
    |> Enum.at(64 - 1)
  end

  def solution2(input) do
    hash_generator(input, 2016)
    |> Enum.at(64 - 1)
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part1()
  23890
  """
  def part1 do
    File.read!(@input_file)
    |> solution1
    |> IO.inspect(label: "Day#{@day} Part1 result ")
  end

  @doc """
  iex> Aoc2016.Day#{@day}.part2()
  22696
  """
  def part2 do
    File.read!(@input_file)
    |> solution2
    |> IO.inspect(label: "Day#{@day} Part2 result ")
  end
end
