defmodule Day8Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day8

  @prompt "test/d8/prompt.txt"
  @example1 "test/d8/e1.txt"
  @example2 "test/d8/e2.txt"

  test "example 1" do
    @example1
    |> Day8.load_file()
    |> Day8.part1(3, 2)
    |> (&(&1 == 1)).()
  end

  test "part1 prompt" do
    @prompt
    |> Day8.load_file()
    |> Day8.part1(25, 6)
    |> (&(&1 == 1792)).()
  end

  test "example 2" do
    @example2
    |> Day8.load_file()
    |> Day8.part2(2, 2)
    |> (&(&1 == [[0, 1], [1, 0]])).()
  end
end
