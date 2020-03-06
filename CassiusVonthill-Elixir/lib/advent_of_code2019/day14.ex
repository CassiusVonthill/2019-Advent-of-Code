defmodule AdventOfCode2019.Day14 do
  defmodule Reaction do
    @enforce_keys [:reference, :cache]
    defstruct [:reference, :cache]

    def new(reference, cache \\ %{}) when is_map(reference) and is_map(cache) do
      %Reaction{reference: reference, cache: cache}
    end

    defp calculate_required(reference, {element, held_amt}) do
      {unit_amt, deps} = Map.fetch!(reference, element)

      multiplier = ceil(held_amt / unit_amt)
      created_amt = multiplier * unit_amt

      case multiplier do
        1 -> deps
        n -> Enum.map(deps, fn {k, v} -> {k, v * n} end)
      end
      |> Map.new()
      |> Map.put(element, -1 * created_amt)
    end

    # def to_ore(%Reaction{cache: cache = %{ORE: v}}) when map_size(cache) == 1, do: v

    def to_ore(reaction = %Reaction{cache: cache, reference: reference}) do
      queue =
        cache
        |> Stream.reject(fn {element, _value} -> element == :ORE end)
        |> Enum.filter(fn {_element, cnt} -> cnt > 0 end)

      if not Enum.empty?(queue) do
        new_cache =
          queue
          |> Stream.map(&calculate_required(reference, &1))
          |> Enum.reduce(cache, &Map.merge(&1, &2, fn _k, v1, v2 -> v1 + v2 end))

        to_ore(%{reaction | cache: new_cache})
      else
        Map.fetch!(cache, :ORE)
      end
    end

    defp binary_search(_reference, low, high, _target) when high - low <= 1 do
      low
    end

    defp binary_search(reference, low, high, target) do
      pivot = div(low + high, 2)

      ore_needed =
        reference
        |> Reaction.new(%{FUEL: pivot})
        |> Reaction.to_ore()

      if ore_needed > target do
        binary_search(reference, low, pivot, target)
      else
        binary_search(reference, pivot, high, target)
      end
    end

    def optimal_fuel(reference, max_ore) do
      cost_one = Reaction.to_ore(%Reaction{reference: reference, cache: %{FUEL: 1}})
      low = div(max_ore, cost_one)
      high = low * 2

      # IO.inspect(cost_one, label: "Cost One: ")
      # IO.inspect(low, label: "Low: ")
      # IO.inspect(high, label: "High: ")

      binary_search(reference, low, high, max_ore)
    end
  end

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
      |> Stream.map(fn {amt, type} -> {String.to_atom(type), String.to_integer(amt)} end)
      |> Enum.split(-1)
      |> (fn {ingredients, [{type, amt}]} -> {type, {amt, Map.new(ingredients)}} end).()
    end
    |> Map.new()
  end

  def part1(reference) do
    reference
    |> Reaction.new(%{FUEL: 1})
    |> Reaction.to_ore()
  end

  def part2(reference, max_ore \\ 1_000_000_000_000) do
    Reaction.optimal_fuel(reference, max_ore)
  end
end
