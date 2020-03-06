defmodule Day14Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day14

  @prompt "test/d14/prompt.txt"
  @example1 "test/d14/e1.txt"
  @example2 "test/d14/e2.txt"
  @example3 "test/d14/e3.txt"
  @example4 "test/d14/e4.txt"

  test "example 1 file loading" do
    @example1
    |> Day14.load_file()
    |> Map.fetch!(:FUEL)
    |> (&assert({1, %{AB: 2, BC: 3, CA: 4}} = &1)).()
  end

  test "example 1 calculating ORE" do
    result =
      @example1
      |> Day14.load_file()
      |> Day14.part1()

    assert result == 165
  end

  test "example 2 calculating ORE" do
    result =
      @example2
      |> Day14.load_file()
      |> Day14.part1()

    assert result == 13312
  end

  test "example 3 calculating ORE" do
    result =
      @example3
      |> Day14.load_file()
      |> Day14.part1()

    assert result == 180_697
  end

  test "example 4 calculating ORE" do
    result =
      @example4
      |> Day14.load_file()
      |> Day14.part1()

    assert result == 2_210_736
  end

  test "prompt calculating ORE" do
    result =
      @prompt
      |> Day14.load_file()
      |> Day14.part1()

    assert result == 362_713
  end

  test "example 2 max fuel" do
    result =
      @example2
      |> Day14.load_file()
      |> Day14.part2()

    assert result == 82_892_753
  end

  test "example 3 max fuel" do
    result =
      @example3
      |> Day14.load_file()
      |> Day14.part2()

    assert result == 5_586_022
  end

  test "example 4 max fuel" do
    result =
      @example4
      |> Day14.load_file()
      |> Day14.part2()

    assert result == 460_664
  end

  test "prompt max fuel" do
    result =
      @prompt
      |> Day14.load_file()
      |> Day14.part2()

    assert result == 3_281_820
  end
end
