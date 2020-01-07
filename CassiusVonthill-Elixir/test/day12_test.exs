defmodule Day12Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day12

  @prompt "test/d12/prompt.txt"
  @example1 "test/d12/e1.txt"

  test "example 1 file loading" do
    @example1
    |> Day12.load_file()
    |> List.first()
    |> (&assert(&1 == {[-1, 0, 2], [0, 0, 0]})).()
  end

  test "example 1 total energy" do
    @example1
    |> Day12.load_file()
    |> Day12.part1(10)
    |> (&assert(&1 == 179)).()
  end

  test "prompt total energy" do
    @prompt
    |> Day12.load_file()
    |> Day12.part1()
    |> (&assert(&1 == 14_907)).()
  end

  test "example 1 count steps" do
    @example1
    |> Day12.load_file()
    |> Day12.part2()
    |> (&assert(&1 == 2_772)).()
  end

  @tag :skip
  test "prompt count steps" do
    @prompt
    |> Day12.load_file()
    |> Day12.part2()
    |> (&assert(&1 == 467_081_194_429_464)).()
  end
end
