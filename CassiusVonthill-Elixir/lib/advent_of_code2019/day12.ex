defmodule AdventOfCode2019.Day12 do
  def load_file(path) when is_binary(path) do
    for line <- File.stream!(path) do
      line
      |> String.trim()
      |> (&Regex.run(~r/<x=(-?\d+), y=(-?\d+), z=(-?\d+)>/, &1)).()
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
      |> (&{&1, [0, 0, 0]}).()
    end
  end

  def part1(moons, steps \\ 1000) when is_list(moons) do
    for m <- apply_steps(moons, steps) do
      for l <- Tuple.to_list(m) do
        l
        |> Enum.map(&abs/1)
        |> Enum.sum()
      end
      |> Math.Enum.product()
    end
    |> Enum.sum()
  end

  def apply_steps(moons, 0), do: moons
  def apply_steps(moons, n), do: apply_steps(step(moons), n - 1)

  def step(moons) do
    moons
    |> Flow.from_enumerable()
    |> Flow.map(&calc_velocity(&1, moons))
    |> Enum.map(fn {p, v} ->
      new_p =
        [p, v]
        |> Enum.zip()
        |> Enum.map(fn {a, b} -> a + b end)

      {new_p, v}
    end)
  end

  def calc_velocity({p, v}, moons) do
    new_v =
      moons
      |> Stream.map(&elem(&1, 0))
      |> Task.async_stream(fn pos ->
        for {a, b} <- Enum.zip(p, pos) do
          cond do
            a > b -> -1
            a < b -> 1
            a == b -> 0
          end
        end
      end)
      |> Stream.map(fn {:ok, v} -> v end)
      |> Enum.reduce(v, fn d, acc ->
        [d, acc]
        |> Enum.zip()
        |> Enum.map(fn {a, b} -> a + b end)
      end)

    {p, new_v}
  end

  def count_steps(moons), do: count_steps(moons, 1, %{})

  def count_steps(_, _cnt, map) when map_size(map) == 3, do: map

  def count_steps(moons, cnt, map) do
    new_moons =
      moons
      |> step

    new_map =
      new_moons
      |> Stream.map(&elem(&1, 1))
      |> Enum.reduce([True, True, True], fn d, acc ->
        [d, acc]
        |> Enum.zip()
        |> Enum.map(fn {a, b} -> a == 0 and b end)
      end)
      |> Stream.with_index()
      |> Enum.reduce(map, fn
        {True, k}, acc ->
          Map.put_new(acc, k, cnt)

        {_, _}, acc ->
          acc
      end)

    count_steps(new_moons, cnt + 1, new_map)
  end

  def part2(moons) when is_list(moons) do
    moons
    |> count_steps()
    |> Stream.map(&elem(&1, 1))
    |> Enum.reduce(1, &Math.lcm(&1, &2))
    |> (&(&1 * 2)).()
  end
end
