defmodule Day6Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day6

  @prompt "test/d6/prompt.txt"
  @example1 "test/d6/e1.txt"
  @example2 "test/d6/e2.txt"

  test "Example 1 orbit count" do
    @example1
    |> Day6.load_file()
    |> Day6.part1()
    |> (&(&1 == 42)).()
  end

  test "Prompt orbit count" do
    @prompt
    |> Day6.load_file()
    |> Day6.part1()
    |> (&(&1 == 417_916)).()
  end

  test "Example 2 orbit transfers" do
    @example2
    |> Day6.load_file()
    |> Day6.part2()
    |> (&(&1 == 4)).()
  end

  test "Prompt orbit transfers" do
    @prompt
    |> Day6.load_file()
    |> Day6.part2()
    |> (&(&1 == 523)).()
  end
end
