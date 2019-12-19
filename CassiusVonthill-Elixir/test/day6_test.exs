defmodule Day6Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day6

  @prompt "test/d6/prompt.txt"
  @example1 "test/d6/e1.txt"

  test "Example 1 orbit count" do
    @example1
    |> Day6.load_file()
    |> Day6.part1()
    |> (&(&1 == 42)).()
  end
end
