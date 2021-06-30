defmodule Aoc2016Test.Day07Test do
  use ExUnit.Case

  import Aoc2016.Day07

  doctest Aoc2016.Day07

  test "Day07 - parse_ipv7" do
    assert parse_ipv7("abba[mnop]qrst") == %{out_bracket: ["abba", "qrst"], in_bracket: ["mnop"]}
  end

  test "Day07 - has_abba" do
    assert has_abba("abba") == true
    assert has_abba("abcd") == false
    assert has_abba("aaaa") == false
    assert has_abba("ioxxoj") == true
  end

  test "Day 07 - has_aba" do
    assert has_aba("aba", ["bab"]) == true
    assert has_aba("xyx", ["xyx"]) == false
  end

  test "Day 07 - is_support_tls" do
    assert parse_ipv7("abba[mnop]qrst") |> is_support_tls() == true
    assert parse_ipv7("abcd[bddb]xyyx") |> is_support_tls() == false
    assert parse_ipv7("aaaa[qwer]tyui") |> is_support_tls() == false
    assert parse_ipv7("ioxxoj[asdfgh]zxcvbn") |> is_support_tls() == true
  end

  test "Day 07 - is_support_ssl" do
    assert parse_ipv7("aba[bab]xyz") |> is_support_ssl() == true
    assert parse_ipv7("xyx[xyx]xyx") |> is_support_ssl() == false
    assert parse_ipv7("aaa[kek]eke") |> is_support_ssl() == true
    assert parse_ipv7("zazbz[bzb]cdb") |> is_support_ssl() == true
  end

  test "Day07 Test1" do
    assert Aoc2016.Day07.solution1(
             "abba[mnop]qrst\nabcd[bddb]xyyx\naaaa[qwer]tyui\nioxxoj[asdfgh]zxcvbn"
           ) == 2
  end

  test "Day07 Test2" do
    # assert Aoc2016.Day07.solution2() == true
  end
end
