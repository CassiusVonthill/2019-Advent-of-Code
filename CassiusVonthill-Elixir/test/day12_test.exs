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

  test "example 1 10 steps" do
    @example1
    |> Day12.load_file()
    |> Day12.part1(10)
    |> (&assert(&1 == 179)).()
  end

  test "prompt" do
    @prompt
    |> Day12.load_file()
    |> Day12.part1()
    |> (&assert(&1 == 14907)).()
  end
end
