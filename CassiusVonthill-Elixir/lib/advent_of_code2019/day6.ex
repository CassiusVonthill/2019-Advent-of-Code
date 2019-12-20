defmodule AdventOfCode2019.Day6 do
  # Solution blatantly stolen from /u/superpangolinseed
  # from the solution megathread with structural changes

  # I spent a considerable amount of hours trying to implement something
  # using trees / graphs and actively avoiding walking around a map.

  # This implementation closely mirrors what I would have done which is why
  # I'm taking it.
  # However, I thought the code to be made more readable and "elixir-like"

  def part1(graph) when is_map(graph) do
    graph
    |> Map.keys()
    |> Enum.flat_map(fn object -> orbits(graph, object) end)
    |> Enum.count()
  end

  def part2(graph) when is_map(graph) do
    [you, san] =
      ["YOU", "SAN"]
      |> Stream.map(&orbits(graph, &1))
      |> Stream.map(&Enum.with_index/1)
      |> Enum.map(&Map.new(&1))

    [you, san]
    |> Stream.map(&Map.keys/1)
    |> Enum.map(&MapSet.new/1)
    |> (fn [x, y] -> MapSet.intersection(x, y) end).()
    |> Enum.map(fn key -> Map.get(you, key) + Map.get(san, key) end)
    |> Enum.min()
  end

  defp orbits(g, object), do: orbits(g, object, []) |> Enum.reverse() |> Enum.drop(1)
  defp orbits(_, nil, found), do: found
  defp orbits(g, object, found), do: orbits(g, Map.get(g, object), [object | found])

  def load_file(path) when is_binary(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, g ->
      [to, from] = String.split(line, ")")
      Map.put(g, from, to)
    end)
  end
end
