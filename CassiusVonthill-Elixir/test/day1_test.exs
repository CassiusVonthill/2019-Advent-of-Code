defmodule Day1Test do
  use ExUnit.Case
  alias AdventOfCode2019.Day1

  test "mass of 12" do
    assert Day1.required_fuel(12) == 2
  end

  test "mass of 14" do
    assert Day1.required_fuel(14) == 2
  end

  test "mass of 1969" do
    assert Day1.required_fuel(1969) == 654
  end

  test "mass of 100756" do
    assert Day1.required_fuel(100_756) == 33583
  end

  test "fuel for masses of 12 and 14" do
    assert Day1.part1([12, 14]) == 4
  end

  test "fuel for fuel of mass 14" do
    assert Day1.fuel_required_fuel_recur(14) == 16
  end

  test "fuel for fuel of mass 654" do
    assert Day1.fuel_required_fuel_recur(654) == 966
  end

  test "fuel for fuel of mass 33583" do
    assert Day1.fuel_required_fuel_recur(33583) == 50346
  end
end
