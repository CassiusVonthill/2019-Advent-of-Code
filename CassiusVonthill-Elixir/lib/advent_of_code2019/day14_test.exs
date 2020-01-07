defmodule Day14Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day14

  @prompt "test/d14/prompt.txt"
  @example1 "test/d14/e1.txt"

  test "example 1 file loading" do
    @example1
    |> Day14.load_file()
    |> (&assert(%{FUEL: {1, [{2, :AB}, {3, :BC}, {4, :CA}]}} = &1)).()
  end

  test "example 1 calculating ORE" do
  end
end
