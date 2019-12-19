defmodule Day2Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day2

  test "example 1" do
    assert Day2.part1([1, 0, 0, 0, 99]) == 2
  end

  test "example 2" do
    assert Day2.part1([2, 3, 0, 3, 99]) == 2
  end

  test "example 3" do
    assert Day2.part1([2, 4, 4, 5, 99, 0]) == 2
  end

  @tag :skip
  test "example 4" do
    assert Day2.part1([1, 1, 1, 4, 99, 5, 6, 0, 99]) == 30
  end
end
