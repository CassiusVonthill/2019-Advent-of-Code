defmodule Day10Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day10

  @prompt "test/d10/prompt.txt"
  @example1 "test/d10/e1.txt"
  @example2 "test/d10/e2.txt"
  @example3 "test/d10/e3.txt"
  @example4 "test/d10/e4.txt"
  @example5 "test/d10/e5.txt"

  test "example 1 file loading" do
    @example1
    |> Day10.load_file()
    |> (&assert(
          &1 == [{4, 0}, {1, 0}, {4, 2}, {3, 2}, {2, 2}, {1, 2}, {0, 2}, {4, 3}, {4, 4}, {3, 4}]
        )).()
  end

  test "example 1" do
    @example1
    |> Day10.load_file()
    |> Day10.part1()
    |> (&assert(&1 === 8)).()
  end

  test "example 2" do
    @example2
    |> Day10.load_file()
    |> Day10.part1()
    |> (&assert(&1 === 33)).()
  end

  test "example 3" do
    @example3
    |> Day10.load_file()
    |> Day10.part1()
    |> (&assert(&1 === 35)).()
  end

  test "example 4" do
    @example4
    |> Day10.load_file()
    |> Day10.part1()
    |> (&assert(&1 === 41)).()
  end

  test "example 5" do
    @example5
    |> Day10.load_file()
    |> Day10.part1()
    |> (&assert(&1 === 210)).()
  end

  test "part 1 prompt" do
    @prompt
    |> Day10.load_file()
    |> Day10.part1()
    |> (&assert(&1 === 253)).()
  end

  test "part 2 example 5" do
    @example5
    |> Day10.load_file()
    |> Day10.part2()
    |> (&assert(&1 === 802)).()
  end

  test "part 2 prompt" do
    @prompt
    |> Day10.load_file()
    |> Day10.part2()
    |> (&assert(&1 === 815)).()
  end
end
