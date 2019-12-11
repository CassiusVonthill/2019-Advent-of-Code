defmodule AdventOfCode2019.Day1 do
  alias AdventOfCode2019.Day1

  def load_file(path) when is_binary(path) do
    with {:ok, content} <- File.read(path),
         masses <- String.split(content, "\n") do
      masses
      |> Enum.map(&String.to_integer/1)
    else
      _ -> IO.puts("The file couldn't be loaded in!")
    end
  end

  def part1(masses) when is_list(masses) do
    Task.async_stream(masses, Day1, :required_fuel, [])
    |> Stream.map(fn {:ok, v} -> v end)
    |> Enum.sum()
  end

  def required_fuel(mass) when is_number(mass) do
    mass
    |> div(3)
    |> (&(&1 - 2)).()
  end

  def part2(masses) when is_list(masses) do
    masses
    |> Task.async_stream(fn module_mass ->
      module_mass
      |> required_fuel
      |> fuel_required_fuel_recur
    end)
    |> Stream.map(fn {:ok, v} -> v end)
    |> Enum.sum()
  end

  def fuel_required_fuel_recur(mass), do: fuel_required_fuel_recur(mass, mass)

  def fuel_required_fuel_recur(mass, acc) when is_number(mass) do
    mass
    |> required_fuel
    |> case do
      new_mass when new_mass <= 0 -> acc
      new_mass -> fuel_required_fuel_recur(new_mass, acc + new_mass)
    end
  end
end
