defmodule AdventOfCode2019.Day14 do
  def load_file(path) when is_binary(path) do
    for line <- File.stream!(path) do
      line
      |> String.trim()
      |> (&Regex.scan(~r/\d+ \w+/, &1)).()
      |> Stream.map(fn [ingredient] ->
        ingredient
        |> String.split()
        |> List.to_tuple()
      end)
      |> Stream.map(fn {amt, type} -> {String.to_integer(amt), String.to_atom(type)} end)
      |> Enum.split(-1)
      |> (fn {ingredients, [{amt, type}]} -> {type, {amt, ingredients}} end).()
    end
    |> Map.new()
  end
end
