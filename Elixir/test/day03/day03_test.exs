defmodule Aoc2016Test.Day03Test do
  use ExUnit.Case
  doctest Aoc2016.Day03

  test "Day03 Test1" do
    assert Aoc2016.Day03.solution1("5 10 25") == 0
  end

  test "Day03 Test2" do
    assert Aoc2016.Day03.solution2("101 301 501\n102 302 502\n103 303 503\n201 401 601\n202 402 602\n203 403 603") == 6
  end
end
