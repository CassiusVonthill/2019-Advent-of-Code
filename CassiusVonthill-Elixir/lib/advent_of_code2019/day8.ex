defmodule AdventOfCode2019.Day8 do
  def load_file(path) do
    path
    |> File.read!()
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(data, width, height)
      when is_list(data) and is_integer(width) and is_integer(height) do
    data
    |> Enum.chunk_every(width * height)
    # Count occurence of each number in a chunk
    |> Stream.map(
      &Enum.reduce(&1, %{}, fn x, acc -> Map.update(acc, x, 1, fn x -> x + 1 end) end)
    )
    # Find which map has fewest zeros
    |> Enum.min_by(&Map.get(&1, 0, 0))
    # Multiple count of ones and twos
    |> (fn m -> m[1] * m[2] end).()
  end

  def part2(data, width, height)
      when is_list(data) and is_integer(width) and is_integer(height) do
    area = width * height

    # Map with pixel ID keys and empty list values
    defaulted =
      0..(area - 1)
      |> Map.new(fn x -> {x, []} end)

    data
    |> Stream.with_index()
    |> Stream.chunk_every(area)
    # Create maps of pixel IDs and their value
    |> Task.async_stream(fn chunk ->
      for {v, i} <- chunk, into: %{} do
        {rem(i, area), v}
      end
    end)
    |> Stream.map(fn {:ok, v} -> v end)
    # Put into "columns" of pixels
    # A list is ID'd by the pixel ID
    # Top layers are to the right
    |> Enum.reduce(defaulted, fn m, acc ->
      Map.merge(acc, m, fn _k, v1, v2 -> [v2 | v1] end)
    end)
    # For each column:
    # Reverse it so that top layers are to the left
    # Find the first non-two number
    |> Task.async_stream(fn {k, v} ->
      {k,
       v
       |> Enum.reverse()
       |> Enum.find(&(&1 != 2))}
    end)
    |> Stream.map(fn {:ok, v} -> v end)
    # To display things in the terminal we need to ensure each pixel is in proper order
    # Then chunk it so it gets formatted on print
    |> Enum.sort_by(fn {k, _v} -> k end)
    |> Stream.map(fn {_k, v} -> v end)
    |> Enum.chunk_every(width)
  end
end
