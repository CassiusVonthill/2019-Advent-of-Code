defmodule Day22Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day22

  @prompt "test/d22prompt.txt"
  @example1 "test/d22/e1.txt"
  @example2 "test/d22/e2.txt"
  @example3 "test/d22/e3.txt"
  @example4 "test/d22/e4.txt"

  test "deal into new stack example" do
    assert Day22.execute("deal into new stack", 0..9) == [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  end

  test "cut 3 example" do
    assert Day22.execute("cut 3", 0..9) == [3, 4, 5, 6, 7, 8, 9, 0, 1, 2]
  end

  test "cut -4 example" do
    assert Day22.execute("cut -4", 0..9) == [6, 7, 8, 9, 0, 1, 2, 3, 4, 5]
  end

  test "deal with increment 3" do
    assert Day22.execute("deal with increment 3", 0..9) == [0, 7, 4, 1, 8, 5, 2, 9, 6, 3]
  end

  test "combined example 1" do
    @example1
    |> Day22.load_file()
    |> Day22.apply_commands(0..9)
    |> (&(&1 == [0, 3, 6, 9, 2, 5, 8, 1, 4, 7])).()
  end

  test "combined example 2" do
    @example2
    |> Day22.load_file()
    |> Day22.apply_commands(0..9)
    |> (&(&1 == [3, 0, 7, 4, 1, 8, 5, 2, 9, 6])).()
  end

  test "combined example 3" do
    @example3
    |> Day22.load_file()
    |> Day22.apply_commands(0..9)
    |> (&(&1 == [6, 3, 0, 7, 4, 1, 8, 5, 2, 9])).()
  end

  test "combined example 4" do
    @example4
    |> Day22.load_file()
    |> Day22.apply_commands(0..9)
    |> (&(&1 == [9, 2, 5, 8, 1, 4, 7, 0, 3, 6])).()
  end
end
