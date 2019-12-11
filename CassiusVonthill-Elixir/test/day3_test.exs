defmodule Day3Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day3

  @prompt "test/d3/prompt.txt"
  @example1 "test/d3/e1.txt"
  @example2 "test/d3/e2.txt"

  test "Example 1 closest distance" do
    @example1
    |> Day3.load_file()
    |> Day3.part1()
    |> (&(&1 == 159)).()
  end

  test "Example 2 closest distance" do
    @example2
    |> Day3.load_file()
    |> Day3.part1()
    |> (&(&1 == 135)).()
  end

  test "prompt closest distance" do
    @prompt
    |> Day3.load_file()
    |> Day3.part1()
    |> (&(&1 == 209)).()
  end

  test "Example 1 fewest steps" do
    @example1
    |> Day3.load_file()
    |> Day3.part2()
    |> (&(&1 == 610)).()
  end

  test "Example 2 fewest steps" do
    @example2
    |> Day3.load_file()
    |> Day3.part2()
    |> (&(&1 == 410)).()
  end

  test "prompt fewest steps" do
    @prompt
    |> Day3.load_file()
    |> Day3.part2()
    |> (&(&1 == 43_258)).()
  end
end
