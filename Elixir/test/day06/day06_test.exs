defmodule Aoc2016Test.Day06Test do
  use ExUnit.Case
  doctest Aoc2016.Day06

  test "Day06 Test1" do
    assert Aoc2016.Day06.solution1(
             "eedadn\ndrvtee\neandsr\nraavrd\natevrs\ntsrnev\nsdttsa\nrasrtv\nnssdts\nntnada\nsvetve\ntesnvt\nvntsnd\nvrdear\ndvrsen\nenarar"
           ) == "easter"
  end

  test "Day06 Test2" do
    assert Aoc2016.Day06.solution2(
             "eedadn\ndrvtee\neandsr\nraavrd\natevrs\ntsrnev\nsdttsa\nrasrtv\nnssdts\nntnada\nsvetve\ntesnvt\nvntsnd\nvrdear\ndvrsen\nenarar"
           ) == "advent"
  end
end
