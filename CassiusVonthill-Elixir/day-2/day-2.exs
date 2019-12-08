defmodule Day2 do
  def load_file(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def part1(intcode) do
    store =
      intcode
      |> Enum.with_index()
      |> Stream.map(fn {a, b} -> {b, a} end)
      |> Enum.into(%{})

    codes =
      intcode
      |> Enum.chunk_every(4, 4, [0, 0, 0])

    process_recur(codes, store)
  end

  defp process_recur([[99, _, _, _] | _], store), do: Map.get(store, 0)

  defp process_recur([[1, a, b, c] | tail], store) do
    [a_v, b_v] = Enum.map([a, b], &Map.get(store, &1))
    process_recur(tail, Map.put(store, c, a_v + b_v))
  end

  defp process_recur([[2, a, b, c] | tail], store) do
    [a_v, b_v] = Enum.map([a, b], &Map.get(store, &1))
    process_recur(tail, Map.put(store, c, a_v * b_v))
  end
end
