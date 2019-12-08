Code.load_file("day-2.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule Day2Test do
  use ExUnit.Case

  test "example 1" do
    Day2.part1([1, 0, 0, 0, 99]) == 2
  end
end
