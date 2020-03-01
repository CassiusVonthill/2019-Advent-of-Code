defmodule AdventOfCode2019.Day16 do
  def load_data(signal) do
    signal
    |> Integer.digits()
  end

  def pattern_generator(index) do
    0
    # Create an infiniste stream of numbers
    |> Stream.iterate(&(&1 + 1))
    # Finds what grouping of the pattern we are in
    |> Stream.map(&div(&1, index))
    # Converts the number into an index of the pattern
    |> Stream.map(&rem(&1, 4))
    # Converts the index to the actual value
    |> Stream.map(fn
      2 -> 0
      3 -> -1
      x -> x
    end)
    |> Stream.drop(1)
  end

  def calc_digit(idx, signal_list) do
    idx
    |> pattern_generator
    |> Stream.zip(signal_list)
    |> Stream.drop(idx - 1)
    |> Stream.map(fn {x, y} -> x * y end)
    |> Enum.sum()
    |> rem(10)
    |> abs
  end

  def phase(signal, phase) do
    phase(signal, length(signal), phase)
  end

  def phase(signal, _len, 0), do: signal

  def phase(signal, len, phase) do
    1..len
    |> Task.async_stream(AdventOfCode2019.Day16, :calc_digit, [signal])
    |> Enum.map(fn {:ok, v} -> v end)
    |> phase(len, phase - 1)
  end

  def part1(signal, phases \\ 100) do
    phase(signal, phases)
    |> Enum.slice(0, 8)
    |> Integer.undigits()
  end
end
