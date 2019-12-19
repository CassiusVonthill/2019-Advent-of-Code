defmodule AdventOfCode2019.Day5 do
  def load_file(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def part1(intcode) do
    intcode
    |> Enum.with_index()
    |> Stream.map(fn {a, b} -> {b, a} end)
    |> Enum.into(%{})
    |> proceed
    |> Map.fetch!(0)
  end

  def proceed(store, idx \\ 0) when is_map(store) and is_integer(idx) do
    cmd = Map.fetch!(store, idx)

    cartridge = load_data(store, idx, cmd)

    case execute(store, cartridge) do
      {:cont, store, jump} -> proceed(store, idx + jump)
      {:halt, store, nil} -> store
    end
  end

  def execute(store, [99]), do: {:halt, store, nil}
  def execute(store, [1, a, b, placement]), do: {:cont, Map.put(store, placement, a + b), 4}
  def execute(store, [2, a, b, placement]), do: {:cont, Map.put(store, placement, a * b), 4}

  def load_data(_store, _idx, 99), do: [99]

  def load_data(store, idx, cmd) when cmd == 1 or cmd == 2 do
    [a, b] =
      1..2
      # Generate the indexs
      |> Stream.map(&(&1 + idx))
      # Find the indexs of the data
      |> Stream.map(&Map.fetch!(store, &1))
      # Get the actual data at the indexs
      |> Enum.map(&Map.fetch!(store, &1))

    placement = Map.fetch!(store, idx + 3)

    [cmd, a, b, placement]
  end
end
