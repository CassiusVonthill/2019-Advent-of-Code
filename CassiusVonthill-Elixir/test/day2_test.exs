defmodule Day2Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day2

  test "example 1" do
    assert Day2.part1([1, 0, 0, 0, 99]) == 2
  end
end
