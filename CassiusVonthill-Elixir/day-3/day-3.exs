defmodule Day3 do
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
    |> Task.async_stream(fn path ->
      path
      |> vecs_to_points
      |> Enum.reduce([{0, 0}], fn {dx, dy}, acc = [{x, y} | _t] ->
        [{x + dx, y + dy} | acc]
      end)
      |> MapSet.new()
      |> MapSet.delete({0, 0})
    end)
    |> Stream.map(fn {:ok, v} -> v end)
    |> Enum.to_list()
    |> (fn [a, b] -> MapSet.intersection(a, b) end).()
    |> Stream.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  defp vecs_to_points(vecs) when is_list(vecs) do
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
end
