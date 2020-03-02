defmodule AdventOfCode2019.Day16 do
  def load_data(signal, duplication \\ 1) when is_binary(signal) do
    signal
    |> String.duplicate(duplication)
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
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

  def phase_1(signal, phase) do
    phase_1(signal, length(signal), phase)
  end

  def phase_1(signal, _len, 0), do: signal

  def phase_1(signal, len, phase) do
    1..len
    |> Task.async_stream(AdventOfCode2019.Day16, :calc_digit, [signal])
    |> Enum.map(fn {:ok, v} -> v end)
    |> phase_1(len, phase - 1)
  end

  def part1(signal, phases \\ 100) do
    phase_1(signal, phases)
    |> Enum.slice(0, 8)
    |> Integer.undigits()
  end

  # Initial call
  def iterate_digits(signal), do: iterate_digits(signal, [])

  # End of iteration
  def iterate_digits([], acc), do: acc

  # First iteration
  def iterate_digits([h | tail], []) do
    new = rem(h, 10)
    iterate_digits(tail, [new])
  end

  # Primary iteration
  def iterate_digits(_signal = [h | tail], acc = [prev | _]) do
    # IO.inspect(signal, label: "Signal: ")
    # IO.inspect(acc, label: "Acc: ")
    new = rem(prev + h, 10)

    # IO.inspect(new, label: "New: ")

    iterate_digits(tail, [new | acc])
  end

  def phase_2(signal, 0), do: signal

  def phase_2(signal, phase) do
    signal
    |> iterate_digits()
    |> Enum.reverse()
    |> phase_2(phase - 1)
  end

  def part2(signal, phases \\ 100) do
    offset =
      signal
      |> Enum.take(7)
      |> Integer.undigits()

    # |> IO.inspect()

    signal
    |> Enum.drop(offset)
    |> Enum.reverse()
    |> phase_2(phases)
    |> Enum.reverse()
    |> Enum.take(8)
    |> Integer.undigits()
  end
end
