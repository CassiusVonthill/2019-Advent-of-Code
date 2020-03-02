defmodule Day16Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day16

  @prompt File.read!("test/d16/prompt.txt")
  @example1 "12345678"
  @example2 "80871224585914546619083218645595"
  @example3 "19617804207202209144916044189917"
  @example4 "69317163492948606335995924319873"

  test "example 1" do
    result =
      @example1
      |> Day16.load_data()
      |> Day16.part1(1)

    assert result == 48_226_158

    result =
      @example1
      |> Day16.load_data()
      |> Day16.part1(4)

    assert result == 01_029_498
  end

  test "pattern generator" do
    result =
      2
      |> Day16.pattern_generator()
      |> Enum.take(10)

    assert result == [0, 1, 1, 0, 0, -1, -1, 0, 0, 1]

    result =
      3
      |> Day16.pattern_generator()
      |> Enum.take(10)

    assert result == [0, 0, 1, 1, 1, 0, 0, 0, -1, -1]
  end

  test "part 1 other examples" do
    result =
      @example2
      |> Day16.load_data()
      |> Day16.part1()

    assert result == 24_176_176

    result =
      @example3
      |> Day16.load_data()
      |> Day16.part1()

    assert result == 73_745_418

    result =
      @example4
      |> Day16.load_data()
      |> Day16.part1()

    assert result == 52_432_133
  end

  test "part 1 challenge" do
    result =
      @prompt
      |> Day16.load_data()
      |> Day16.part1()

    assert result == 89_576_828
  end

  test "part 2 examples" do
    result =
      "03036732577212944063491565474664"
      |> Day16.load_data(10_000)
      |> Day16.part2()

    assert result == 84_462_026

    result =
      "02935109699940807407585447034323"
      |> Day16.load_data(10_000)
      |> Day16.part2()

    assert result == 78_725_270

    result =
      "03081770884921959731165446850517"
      |> Day16.load_data(10_000)
      |> Day16.part2()

    assert result == 53_553_731
  end

  test "part 2 challenge" do
    result =
      @prompt
      |> Day16.load_data(10_000)
      |> Day16.part2()

    # |> IO.inspect()

    assert result == 23_752_579
  end
end
