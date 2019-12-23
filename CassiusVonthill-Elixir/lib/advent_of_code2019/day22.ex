defmodule AdventOfCode2019.Day22 do
  def load_file(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
  end

  def part1(commands, deck \\ 0..10_006) do
    commands
    |> apply_commands(deck)
    |> Enum.find_index(&(&1 == 2019))
  end

  def apply_commands(commands, deck) do
    Enum.reduce(commands, deck, &execute(&1, &2))
  end

  def execute("deal into new stack", cards), do: Enum.reverse(cards)

  def execute("cut " <> n, cards) do
    cards
    |> Enum.split(String.to_integer(n))
    |> (fn {a, b} -> b ++ a end).()
  end

  def execute("deal with increment " <> _n = prompt, %Range{} = cards) do
    execute(prompt, Enum.to_list(cards))
  end

  def execute("deal with increment " <> n, cards) when is_list(cards) do
    deck_length = length(cards)
    increment = String.to_integer(n)

    cards
    |> Enum.with_index()
    |> Stream.map(fn {a, b} -> {b, a} end)
    |> Flow.from_enumerable()
    |> Flow.partition()
    |> Flow.reduce(&Map.new/0, fn {k, v}, acc ->
      Map.put_new(acc, rem(k * increment, deck_length), v)
    end)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
  end
end
