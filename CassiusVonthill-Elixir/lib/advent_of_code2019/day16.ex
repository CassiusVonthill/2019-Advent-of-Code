defmodule AdventOfCode2019.Day16 do
  def load_data(signal, duplication \\ 1) when is_binary(signal) do
    signal
    |> String.duplicate(duplication)
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def calc_digit(idx, signal_list) do
    chunked =
      signal_list
      # The offset
      |> Stream.drop(idx - 1)
      # Groups of what pattern item
      |> Stream.chunk_every(idx)
      # We don't care about where the
      # pattern is zero
      |> Enum.take_every(2)

    concant_and_sum = fn x ->
      x
      |> Stream.concat()
      |> Enum.sum()
    end

    optimists =
      chunked
      |> Enum.take_every(2)
      |> concant_and_sum.()

    pessimists =
      chunked
      |> Enum.drop_every(2)
      |> concant_and_sum.()

    rem(optimists - pessimists, 10) |> abs
  end

  def phase_1(signal, _len, 0), do: signal

  def phase_1(signal, len, phase) do
    1..len
    |> Task.async_stream(AdventOfCode2019.Day16, :calc_digit, [signal])
    |> Enum.map(fn {:ok, v} -> v end)
    |> phase_1(len, phase - 1)
  end

  def part1(signal, phases \\ 100) do
    phase_1(signal, length(signal), phases)
    |> Enum.take(8)
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
    |> Enum.reverse()
    |> iterate_digits()
    |> phase_2(phase - 1)
  end

  def part2(signal, phases \\ 100) do
    offset =
      signal
      |> Enum.take(7)
      |> Integer.undigits()

    signal
    |> Enum.drop(offset)
    |> phase_2(phases)
    |> Enum.take(8)
    |> Integer.undigits()
  end
end
