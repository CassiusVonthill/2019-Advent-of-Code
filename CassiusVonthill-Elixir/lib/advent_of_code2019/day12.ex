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
      for pos <- Enum.map(moons, &elem(&1, 0)) do
        for {a, b} <- Enum.zip(p, pos) do
          cond do
            a > b -> -1
            a < b -> 1
            a == b -> 0
          end
        end
      end
      |> Enum.reduce(v, fn d, acc ->
        [d, acc]
        |> Enum.zip()
        |> Enum.map(fn {a, b} -> a + b end)
      end)

    {p, new_v}
  end
end
