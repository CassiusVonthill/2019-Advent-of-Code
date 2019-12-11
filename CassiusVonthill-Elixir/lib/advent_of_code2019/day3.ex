defmodule AdventOfCode2019.Day3 do
  def load_file(path) do
    for line <- File.stream!(path),
        trimmed = String.trim(line) do
      for(instruction <- String.split(trimmed, ",")) do
        instruction
        |> String.split_at(1)
        |> (fn {direction, amplitude} ->
              {String.to_atom(direction), String.to_integer(amplitude)}
            end).()
      end
    end
  end

  def part1(wire_paths) when is_list(wire_paths) do
    wire_paths
    |> Task.async_stream(Day3, :vecs_to_points, [])
    |> Stream.map(fn {:ok, v} -> v end)
    |> locate_intersections
    |> Stream.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  def vecs_to_movements(vecs) when is_list(vecs) do
    for {direction, amplitude} <- vecs,
        _cnt <- 1..amplitude do
      case direction do
        :U -> {0, 1}
        :D -> {0, -1}
        :L -> {-1, 0}
        :R -> {1, 0}
      end
    end
  end

  def vecs_to_points(vecs) do
    vecs
    |> vecs_to_movements
    |> Enum.reduce([{0, 0}], fn {dx, dy}, acc = [{x, y} | _t] ->
      [{x + dx, y + dy} | acc]
    end)
  end

  defp locate_intersections(paths) do
    paths
    |> Stream.map(&MapSet.new(&1))
    |> Stream.map(&MapSet.delete(&1, {0, 0}))
    |> Enum.to_list()
    |> (fn [a, b] -> MapSet.intersection(a, b) end).()
  end

  def part2(wire_paths) when is_list(wire_paths) do
    path_points =
      wire_paths
      |> Task.async_stream(Day3, :vecs_to_points, [])
      |> Stream.map(fn {:ok, v} -> v end)

    intersection_points =
      path_points
      |> locate_intersections
      |> MapSet.to_list()

    path_points
    |> Task.async_stream(fn path ->
      path
      # We preappend during the reduction in vecs_to_points
      # for proper amount of hops we need to order them correctly again
      |> Enum.reverse()
      |> Stream.with_index()
      |> Map.new()
    end)
    |> Enum.map(fn {:ok, v} -> v end)
    |> (fn [a, b] -> Map.merge(a, b, fn _k, v1, v2 -> v1 + v2 end) end).()
    |> Map.take(intersection_points)
    |> Enum.min_by(&elem(&1, 1))
    |> elem(1)
  end
end
